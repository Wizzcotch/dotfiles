#!/usr/bin/env python

# Some enhancements if I have time:
#
# - Diff also for modification time (perhaps to suggest --reverse or smarter sync operations)
# - Employ pretty print or tabularize for better diff display
# - Delineate stages with indentation/markings for readability
# - Add verbosity flag
# - Add ignore flag (to ignore files/categories)
# - Add customized support for gitconfig (e.g. want to extract only aliases)

import argparse
import filecmp
import subprocess
import yaml

from os import path
from shutil import copy2

HOME_DIR = path.expanduser("~")
DEFAULT_DOTFILES_PATH = path.join(HOME_DIR, "dotfiles")
DEFAULT_DEST_PATH = HOME_DIR

def create_parser():
    """ Create arg parser """
    parser = argparse.ArgumentParser(description="Sync files to dotfiles repo", formatter_class=argparse.RawTextHelpFormatter)

    # Add mode argument
    mode_choices = {
            "list": "List all dotfiles specified in dotfiles.yaml",
            "diff": "Show all diffs between src and dest dotfiles",
            "sync": "Sync dotfiles between src and dest"
    }

    mode_help = "\n   " + "\n   ".join("{0} - {1}".format(cmd, msg) for (cmd, msg) in mode_choices.items())
    parser.add_argument("mode", choices=mode_choices.keys(), default="list", help="Run in one of the following modes: " + mode_help, metavar="mode")

    # Add other arguments
    parser.add_argument("-s", "--src", default=DEFAULT_DOTFILES_PATH, help="Path of dotfiles dir/repo")
    parser.add_argument("-d", "--dest", default=DEFAULT_DEST_PATH, help="Path to unpack dotfiles")
    parser.add_argument("-n", "--no-sync", action="store_true", help="Do not perform sync. Only print actions")
    parser.add_argument("-y", "--yaml", default=path.join(DEFAULT_DOTFILES_PATH, "dotfiles.yaml"), help="Path to dotfiles.yaml")
    parser.add_argument("--reverse", action="store_true", help="Reverse sync direction (i.e. dest => src)")

    return parser

def get_dotfiles(dotfile_yaml):
    """ Get list of dotfiles to sync """
    try:
        with open(dotfile_yaml, "r") as f:
            print("Loading '{0}'...".format(dotfile_yaml))
            return yaml.load(f)
    except Exception as e:
        print("Error opening/reading '{0}': {1}".format(dotfile_yaml, str(e)))
        return None

def diff_dotfiles(dir1, dir2, dotfiles):
    """ Diff dotfiles between two directories """
    diffs = {}
    for category in dotfiles:
        entries = []
        for df in dotfiles[category]:
            path1 = path.join(dir1, df)
            path2 = path.join(dir2, df)

            exists1 = path.isfile(path1)
            exists2 = path.isfile(path2)

            # Compare file contents if both file exists
            if exists1 and exists2:
                status = "Same" if filecmp.cmp(path1, path2, shallow=False) else "Different"
                entries.append({'filename': df, 'dir1': status, 'dir2': status})
            # Otherwise, state whether they're present or missing
            else:
                st_func = lambda s : "Exists" if s else "Missing"
                entries.append({'filename': df, 'dir1': st_func(exists1), 'dir2': st_func(exists2)})

        diffs[category] = entries

    return diffs

def copy_dotfiles(src, dest, dotfiles, diff_only=True, dry_run=False):
    """ Copy dotfiles from src to dest """

    should_copy = lambda f : f['dir1'] != "Missing" and ((diff_only and f['dir2'] in ['Different', 'Missing']) or not diff_only)
    gen_copy_args = lambda f : {'src': path.join(src, f), 'dest': path.join(dest, f)}

    diffs = diff_dotfiles(src, dest, dotfiles)
    staged = {c:[gen_copy_args(d['filename']) for d in diffs[c] if should_copy(d)] for c,d in diffs.items()}

    if len(staged) <= 0:
        print("No files to sync")
        return

    for c in staged:
        if len(staged[c]) <= 0:
            print("No {0} files to sync".format(c))
            continue

        print("{0} the following {1} files...".format("Will copy" if dry_run else "Copying", c))
        for f in staged[c]:
            print("{0} ==> {1}".format(f['src'], f['dest']))

            if not dry_run:
                try:
                    copy2(f['src'], f['dest'])
                except Exception as e:
                    print("Error when copying {0} to {1}: {2}".format(f['src'], f['dest'], str(e)))

def main():
    """ Main function """
    args = create_parser().parse_args()

    src, dest = (args.dest, args.src) if args.reverse else (args.src, args.dest)
    print("SRC: {0}, DEST: {1}".format(src, dest))

    dotfiles = get_dotfiles(args.yaml)
    if not dotfiles or len(dotfiles) <= 0:
        print("No files to sync from '{0}'".format(src))
        return 0

    # TODO: Create dict for switching by mode
    if args.mode == "list":
        print(str(dotfiles))
    elif args.mode == "diff":
        # TODO: Make this better
        diffs = diff_dotfiles(src, dest, dotfiles)
        for d in diffs:
            print(d)
            for e in diffs[d]:
                print(str(e))
    elif args.mode == "sync":
        copy_dotfiles(src, dest, dotfiles, dry_run=args.no_sync)
    else:
        print("Unsupported mode")
        return 1

    return 0


if __name__ == "__main__":
    main()
