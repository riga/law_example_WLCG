#!/usr/bin/env bash

# Bootstrap file for remote WLCG jobs that is automatically called by the law
# remote job wrapper script to find the setup.sh file of this example which
# sets up software and some environment variables. The "{{analysis_path}}"
# variable is defined in the workflow base tasks in analysis/framework.py.
# TODO: update text

load_replica() {
    local remote_base="$1"
    local bundle_re="$2"
    local arc_path="$3"

    local arc="$( gfal-ls "$remote_base" | grep -Po "$bundle_re" | shuf -n 1 )"
    if [ -z "$arc" ]; then
        >&2 echo "could not determine archive to load from $remote_base"
        return "1"
    fi

    gfal-copy "$remote_base/$arc" "$arc_path"
    if [ "$?" != "0" ]; then
        >&2 echo "could not load archive $arc from $remote_base"
        return "1"
    fi
}

action() {

    echo "HELLO WLCG!"
    # #
    # # set env variables
    # #

    # export PATH_ORIG="$PATH"
    # export PYTHONPATH_ORIG="$PYTHONPATH"
    # export LD_LIBRARY_PATH_ORIG="$LD_LIBRARY_PATH"

    # export JTSF_DATA="$HOME/jtsf_data"
    # export JTSF_SOFTWARE="$JTSF_DATA/software"
    # export JTSF_STORE="$JTSF_DATA/store"
    # export JTSF_LOCAL_CACHE="$JTSF_DATA/cache"
    # export JTSF_GRID_USER="{{jtsf_grid_user}}"
    # export JTSF_CMSSW_SETUP="{{jtsf_cmssw_setup}}"

    # export SCRAM_ARCH="{{scram_arch}}"
    # export CMSSW_VERSION="{{cmssw_version}}"
    # export CMSSW_BASE="$JTSF_DATA/cmssw/$CMSSW_VERSION"

    # export JTSF_ON_GRID="1"

    # mkdir -p "$JTSF_DATA"


    # #
    # # load the software bundle
    # #

    # mkdir -p "$JTSF_SOFTWARE"
    # cd "$JTSF_SOFTWARE"
    # load_replica "{{software_base_url}}" "software\.\d+\.tgz" "software.tgz"
    # tar -xzf "software.tgz"
    # rm "software.tgz"
    # cd "$HOME"


    # #
    # # load the repo bundle
    # #

    # load_replica "{{repo_base}}" "jet-tagging-sf\.{{repo_checksum}}\.\d+\.tgz" "repo.tgz"
    # tar -xzf "repo.tgz"
    # rm "repo.tgz"

    # # source the repo setup
    # source "jet-tagging-sf/setup.sh"
}
action "$@"
