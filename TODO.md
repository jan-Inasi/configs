- alias cdgit which returns to the git home dir `cd "$(git rev-parse --show-toplevel)"`
- interactive just config sync, for each config
  1. print diff
  2. prompt apply [y/n]
  3. install if yes

