# create package-lock.json for audit patch
npm i --package-lock-only

# fix audit issues
npm audit fix

# remove old yarn.lock
rm yarn.lock

# create new yarn.lock from package-lock.json
yarn import

# clean up
rm package-lock.json
