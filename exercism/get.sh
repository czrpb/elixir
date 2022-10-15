#!/usr/bin/env bash

set -x

exercism configure -w $PWD

exercism download --exercise=$1 --track=elixir

mv -v elixir/$1 .

cd $1

file="$(echo $1 | tr - _)"

cat <<EOL > submit.sh
#!/usr/bin/env bash

set -x
exercism submit lib/$file.ex
EOL

chmod 755 submit.sh
