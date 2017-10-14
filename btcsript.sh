#!/bin/sh

date

#transferwise exchange rate
# TRWEURBRL=$(curl -s https://transferwise.com/gb/currency-converter/eur-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWGBPBRL=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWUSDBRL=$(curl -s https://transferwise.com/gb/currency-converter/usd-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)

#transferwise fee
TRWFEE=0.02439

#exchange rate + transferwise fees
GOOUSDBRL=$(curl -s https://finance.google.com/finance?q=USDBRL | grep  "1 USD = " | grep "?[0-9]*\.[0-9]*" -Eo)
USDBRL=$(echo "scale=3;($GOOUSDBRL/(1-$TRWFEE))" | bc)
echo USD = $USDBRL

GOOGBPBRL=$(curl -s https://finance.google.com/finance?q=GBPBRL | grep  "1 GBP = " | grep "?[0-9]*\.[0-9]*" -Eo)
GBPBRL=$(echo "scale=3;($GOOGBPBRL/(1-$TRWFEE))" | bc)
echo GBP = $GBPBRL

GOOEURBRL=$(curl -s https://finance.google.com/finance?q=EURBRL | grep  "1 EUR = " | grep "?[0-9]*\.[0-9]*" -Eo)
EURBRL=$(echo "scale=3;($GOOEURBRL/(1-$TRWFEE))" | bc)
echo EUR = $EURBRL

# GOOGBPEUR=$(curl -s https://finance.google.com/finance?q=GBPEUR | grep  "1 GBP = " | grep "?[0-9]*\.[0-9]*" -Eo)
# GBPEUR=$(echo "scale=3;($GOOGBPEUR/(1-$TRWFEE))" | bc)
# echo GBPEUR = $GBPEUR

TRWGBPEUR=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-eur-rate?amount=1000 | grep " data-rate=\"EUR\">" | grep "?[0-9]*\.[0-9]*" -Eo)
echo GBPEUR = $TRWGBPEUR

# echo google USD = $GOOUSDBRL
# echo google GBP = $GOOGBPBRL
# echo google EUR = $GOOEURBRL

# echo TW USD = $TRWUSDBRL
# echo TW GBP = $TRWGBPBRL
# echo TW EUR = $TRWEURBRL

# echo TRWEURGBP = $TRWEURGBP
# echo GOOGBPEUR = $GOOGBPEUR

KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTUSD)
KRABTCUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
echo KRABTCUSD = $KRABTCUSD \($KRABTCUSD_MIN - $KRABTCUSD_MAX\)

KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHUSD)
KRABCHUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABCHUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABCHUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
echo KRABCHUSD = $KRABCHUSD \($KRABCHUSD_MIN - $KRABCHUSD_MAX\)

KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTEUR)
KRABTCEUR=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCEUR_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
KRABTCEUR_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]*" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
echo KRABTCEUR = $KRABTCEUR \($KRABTCEUR_MIN - $KRABTCEUR_MAX\)

COI=$(curl -s "https://webapi.coinfloor.co.uk:8090/bist/XBT/GBP/ticker/")
COIBTCGBP=$(echo $COI | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
COIBTCGBP_MIN=$(echo $COI | grep -Eo "\"low\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
COIBTCGBP_MAX=$(echo $COI | grep -Eo "\"high\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
echo COIBTCGBP = $COIBTCGBP \($COIBTCGBP_MIN - $COIBTCGBP_MAX\)

FOX=$(curl -s "https://api.blinktrade.com/api/v1/BRL/ticker")
FOXBTCBRL=$(echo $FOX | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
FOXBTCBRL_MIN=$(echo $FOX | grep -Eo "\"low\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
FOXBTCBRL_MAX=$(echo $FOX | grep -Eo "\"high\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
echo FOXBTCBRL = $FOXBTCBRL \($FOXBTCBRL_MIN - $FOXBTCBRL_MAX\)

NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker")
NEGBTCBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
NEGBTCBRL_MIN=$(echo $NEG | grep -Eo "\"low\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
NEGBTCBRL_MAX=$(echo $NEG | grep -Eo "\"high\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
echo NEGBTCBRL = $NEGBTCBRL \($NEGBTCBRL_MIN - $NEGBTCBRL_MAX\)

BTCFOXBRLUSD=$(echo "scale=3;$FOXBTCBRL/$KRABTCUSD" | bc)
BTCNEGBRLUSD=$(echo "scale=3;$NEGBTCBRL/$KRABTCUSD" | bc)
BTCFOXBRLGBP=$(echo "scale=3;$FOXBTCBRL/$COIBTCGBP" | bc)
BTCNEGBRLGBP=$(echo "scale=3;$NEGBTCBRL/$COIBTCGBP" | bc)
BTCFOXBRLEUR=$(echo "scale=3;$FOXBTCBRL/$KRABTCEUR" | bc)
BTCNEGBRLEUR=$(echo "scale=3;$NEGBTCBRL/$KRABTCEUR" | bc)

PCTFOXUSD=$(echo "scale=3;100*(($BTCFOXBRLUSD/$USDBRL)-1)" | bc)
PCTNEGUSD=$(echo "scale=3;100*(($BTCNEGBRLUSD/$USDBRL)-1)" | bc)

PCTFOXGBP=$(echo "scale=3;100*(($BTCFOXBRLGBP/$GBPBRL)-1)" | bc)
PCTNEGGBP=$(echo "scale=3;100*(($BTCNEGBRLGBP/$GBPBRL)-1)" | bc)

PCTFOXEUR=$(echo "scale=3;100*(($BTCFOXBRLEUR/$EURBRL)-1)" | bc)
PCTNEGEUR=$(echo "scale=3;100*(($BTCNEGBRLEUR/$EURBRL)-1)" | bc)


echo BTCFOXBRLUSD = $BTCFOXBRLUSD \(${PCTFOXUSD}\%\)
echo BTCNEGBRLUSD = $BTCNEGBRLUSD \(${PCTNEGUSD}\%\)

echo BTCFOXBRLGBP = $BTCFOXBRLGBP \(${PCTFOXGBP}\%\)
echo BTCNEGBRLGBP = $BTCNEGBRLGBP \(${PCTNEGGBP}\%\)

echo BTCFOXBRLEUR = $BTCFOXBRLEUR \(${PCTFOXEUR}\%\)
echo BTCNEGBRLEUR = $BTCNEGBRLEUR \(${PCTNEGEUR}\%\)
echo =============================
