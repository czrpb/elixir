exercism download --exercise=$1 --track=elixir

echo "exercism submit lib/$1:s/-/_/.ex" > $1/submit.sh

cd $1
