#!/bin/sh

# KRABTCUSD=$(php5 kraken.php | grep [c] -A2 | grep "\[0\]" | grep " => ?[0-9]*\.?[0-9]*" -Eo  | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCUSD=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTUSD | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABCHUSD=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHUSD | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)

FOXBTCBRL=$(curl -s "https://api.blinktrade.com/api/v1/BRL/ticker" | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
NEGBTCBRL=$(curl -s "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker" | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")

echo KRABTCUSD = $KRABTCUSD
echo KRABCHUSD = $KRABCHUSD
echo FOXBTCBRL = $FOXBTCBRL
echo NEGBTCBRL = $NEGBTCBRL

BTCFOXBTCBRL=$(echo "scale=3;$FOXBTCBRL/$KRABTCUSD" | bc)
BTCNEGBRLUSD=$(echo "scale=3;$NEGBTCBRL/$KRABTCUSD" | bc)

echo BTCFOXBTCBRL = $BTCFOXBTCBRL
echo BTCNEGBRLUSD = $BTCNEGBRLUSD
