# libunionpreload | [Download amd64](https://github.com/project-portable/libunionpreload/releases/download/amd64/libunionpreload.so)
This lib tries to create the impression of a union filesystem, effectively creating the impression to the payload application that the specified directory are overlayed over /. This works as long as the payload application is a dynamically linked binary. It also intercepts "execve" calls to ensure that the sub processes also believe that the current directory is overlayed.

# How it works in praticle:

```bash
export CURRENT_DIRECTORY="$(dirname "$(readlink -f "${0}")")"
export UNION_PRELOAD="/example"
export LD_PRELOAD="${CURRENT_DIRECTORY}/libunionpreload.so"

# If The application try access /usr/lib/bar.so, libunionpreload.so will "replace" 
# the / directory with /example, so, application now is looking for  /example/usr/lib/bar.so,
# if the file exists it is will be used even if the original looking file (/usr/lib/bar.so) exist. 
# If /example/usr/lib/bar.so doesn't exists, the /usr/lib/bar.so is used
```

# How to use
Since it works by reading an environment variable and needs to be preloaded, you will need a `bash script` with the following lines before running your application:

```bash
#!/usr/bin/env sh

export CURRENT_DIRECTORY="$(dirname "$(readlink -f "${0}")")"
export UNION_PRELOAD="${CURRENT_DIRECTORY}"
export LD_PRELOAD="${CURRENT_DIRECTORY}/libunionpreload.so"

# call your application here
```

# How to build
1. Clone repository:

```
git clone https://github.com/project-portable/libunionpreload.git
```
2. Enter repository 
```
cd libunionpreload
```
3. Run `make`
```
make
```
# See in action

Run test script:

```
sh ./test-libunionpreload.sh
```
# Credits

* [Michael Terry](https://github.com/mikix/deb2snap/blob/master/src/preload.c)
