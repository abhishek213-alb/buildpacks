load("@io_bazel_rules_go//go:def.bzl", "go_test")

"""Module for initializing aruments by python version"""

load(":runtime.bzl", "gae_runtimes")

def pythonargs(runImageTag = ""):
    """Create a new key-value map of arguments for python test

    Returns:
        A key-value map of the arguments
    """
    args = {}
    for n, v in gae_runtimes.items():
        args[v] = newArgs(n.replace("python", ""), runImageTag)
    return args

def newArgs(version, runImageTag):
    return {
        "-run-image-override": runImage(version, runImageTag),
    }

def runImage(version, runImageTag):
    if runImageTag != "":
        return "gcr.io/gae-runtimes-private/buildpacks/python" + version + "/run:" + runImageTag
    else:
        return "gcr.io/gae-runtimes/buildpacks/python" + version + "/run"
