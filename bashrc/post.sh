#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

curl \
    -H "x-imvu-sauce: xxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -H "Cookie: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -d "preview_image=$(cat /Users/yhuang/imvu_code/website1/test_images/test20x50.png | base64)" \
    https://api.imvu.com/product/product-53328306 > product-53328306-test20x50-post.json

# recomment Content-Type: application/json version, to avoid some weird issue of losing '+', '=' characters.
curl \
    -H "x-imvu-sauce: xxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -H "Cookie: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -H "Content-Type: application/json" \
    -d '{
            "cfl": "'"$(cat /Users/yhuang/imvu_code/website1/scripts/test-data/product914462.cfl | base64)"'",
            "email": "'"${EMAIL}"'",
            "image_filename": "test100x80.png",
            "profit": 5,
            "is_purchasable": true
        }' \
    https://api.imvu.com/product > product-create.json

curl \
   -H "Accept: application/json" \
   -H "Content-Type: application/json" \
   -H "x-imvu-sauce: $SAUCE" \
   -H "Cookie: osCsid=$OSCSID" \
   -d @body.json \
   https://api.imvu.com/gift > gift.json       
