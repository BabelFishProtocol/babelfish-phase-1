#! /bin/bash

rm -f state_development.json
yarn migrate
yarn script transferAdmin
yarn script transferOwnership

# yarn script e2e
