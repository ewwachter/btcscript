#!/bin/sh


#transferwise exchange rate
TRWEURBRL=$(curl -s https://transferwise.com/gb/currency-converter/eur-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
TRWGBPBRL=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
TRWUSDBRL=$(curl -s https://transferwise.com/gb/currency-converter/usd-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)

GOOGBPBRL=$(curl -s https://finance.google.com/finance?q=GBPBRL | grep  "1 GBP = " | grep "?[0-9]*\.[0-9]*" -Eo)
GOOEURBRL=$(curl -s https://finance.google.com/finance?q=EURBRL | grep  "1 EUR = " | grep "?[0-9]*\.[0-9]*" -Eo)
GOOUSDBRL=$(curl -s https://finance.google.com/finance?q=USDBRL | grep  "1 USD = " | grep "?[0-9]*\.[0-9]*" -Eo)

#transferwise fee
TRWFEE=0.02439

#exchange rate + transferwise fees
EURBRL=$(echo "scale=3;($GOOEURBRL/(1-$TRWFEE))" | bc)
GBPBRL=$(echo "scale=3;($GOOGBPBRL/(1-$TRWFEE))" | bc)
USDBRL=$(echo "scale=3;($GOOUSDBRL/(1-$TRWFEE))" | bc)


# echo google USD = $GOOUSDBRL
# echo google GBP = $GOOGBPBRL
# echo google EUR = $GOOEURBRL

# echo TW USD = $TRWUSDBRL
# echo TW GBP = $TRWGBPBRL
# echo TW EUR = $TRWEURBRL

echo USD = $USDBRL
echo GBP = $GBPBRL
echo EUR = $EURBRL
echo ======================

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

PCTFOXUSD=$(echo "scale=3;($BTCFOXBRLUSD/$USDBRL)-1" | bc)
PCTNEGUSD=$(echo "scale=3;($BTCNEGBRLUSD/$USDBRL)-1" | bc)

PCTFOXGBP=$(echo "scale=3;($BTCFOXBRLGBP/$GBPBRL)-1" | bc)
PCTNEGGBP=$(echo "scale=3;($BTCNEGBRLGBP/$GBPBRL)-1" | bc)

PCTFOXEUR=$(echo "scale=3;($BTCFOXBRLEUR/$EURBRL)-1" | bc)
PCTNEGEUR=$(echo "scale=3;($BTCNEGBRLEUR/$EURBRL)-1" | bc)


echo BTCFOXBRLUSD = $BTCFOXBRLUSD \(${PCTFOXGBP}\%\)
echo BTCNEGBRLUSD = $BTCNEGBRLUSD \(${PCTNEGGBP}\%\)

echo BTCFOXBRLGBP = $BTCFOXBRLGBP \(${PCTFOXEUR}\%\)
echo BTCNEGBRLGBP = $BTCNEGBRLGBP \(${PCTNEGEUR}\%\)

echo BTCFOXBRLEUR = $BTCFOXBRLEUR \(${PCTFOXEUR}\%\)
echo BTCNEGBRLEUR = $BTCNEGBRLEUR \(${PCTNEGEUR}\%\)
