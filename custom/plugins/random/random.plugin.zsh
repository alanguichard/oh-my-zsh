# Randomness functions

flipcoin() {
  [[ $((RANDOM % 2)) == 0 ]] && echo TAILS || echo HEADS
}

rolldie() {
  if [[ -n "$1" ]]; then
    SIDES="$1"
  else
    SIDES=6
  fi
  echo $((RANDOM % $SIDES))
}

# Given an input n, gives a random string of length n.
# If no input supplied, generates a 64 character string.
randgen() {
  if [[ $# -eq 0 ]]; then
    openssl rand -hex 32
  else
    openssl rand -hex $1 | cut -c1-$1
  fi
}
