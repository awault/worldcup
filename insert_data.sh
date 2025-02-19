#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Read the teams from games.csv and insert unique team names into teams table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    if [[ $WINNER != "winner" ]] # Skips header row
    then
      # Insert name of winning team if it doesn't already exist
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER' " )
      if [[ -z $TEAM_ID ]]
      then
        $PSQL "INSERT INTO teams(name) VALUES('$WINNER')"
      fi
      # Insert name of opponent if it doesn't already exist
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT' " )
      if [[ -z $TEAM_ID ]]
      then
        $PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')"
      fi
    fi
  done