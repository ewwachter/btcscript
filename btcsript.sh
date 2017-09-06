#!/bin/sh

KRABTCUSD=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTUSD | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCEUR=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTEUR | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABCHUSD=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHUSD | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)

COIBTCGBP=$(curl -s "https://webapi.coinfloor.co.uk:8090/bist/XBT/GBP/ticker/" | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")

FOXBTCBRL=$(curl -s "https://api.blinktrade.com/api/v1/BRL/ticker" | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")

NEGBTCBRL=$(curl -s "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker" | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")

echo KRABTCUSD = $KRABTCUSD
echo KRABCHUSD = $KRABCHUSD
echo KRABTCEUR = $KRABTCEUR
echo FOXBTCBRL = $FOXBTCBRL
echo NEGBTCBRL = $NEGBTCBRL
echo COIBTCGBP = $COIBTCGBP

BTCFOXBRLUSD=$(echo "scale=3;$FOXBTCBRL/$KRABTCUSD" | bc)
BTCNEGBRLUSD=$(echo "scale=3;$NEGBTCBRL/$KRABTCUSD" | bc)
BTCFOXBRLGBP=$(echo "scale=3;$FOXBTCBRL/$COIBTCGBP" | bc)
BTCNEGBRLGBP=$(echo "scale=3;$NEGBTCBRL/$COIBTCGBP" | bc)
BTCFOXBRLEUR=$(echo "scale=3;$FOXBTCBRL/$KRABTCEUR" | bc)
BTCNEGBRLEUR=$(echo "scale=3;$NEGBTCBRL/$KRABTCEUR" | bc)

echo BTCFOXBRLUSD = $BTCFOXBRLUSD
echo BTCNEGBRLUSD = $BTCNEGBRLUSD

echo BTCFOXBRLGBP = $BTCFOXBRLGBP
echo BTCNEGBRLGBP = $BTCNEGBRLGBP

echo BTCFOXBRLEUR = $BTCFOXBRLEUR
echo BTCNEGBRLEUR = $BTCNEGBRLEUR
