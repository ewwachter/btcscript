#!/bin/sh


get_price_kraken () {
	# echo name: $1 addr: $2 curreny_conv: $3

	EXCHANGE=$(curl -s  $2)
	# KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTUSD)
	PRICE=$(echo $EXCHANGE | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$PRICE" ]; do
		EXCHANGE=$(curl -s  $2)
		PRICE=$(echo $EXCHANGE | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		printf .
		sleep 5
	done
	MIN=$(echo $EXCHANGE | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	MAX=$(echo $EXCHANGE | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BRL=$(echo "scale=3;$PRICE*$3" | bc)
	echo "\033[2K"$1 = $PRICE \($MIN - $MAX\) R\$ $BRL

	local  __resultvar=$4
	local  myresult=$PRICE
	eval $__resultvar="'$myresult'"
}


get_price_bitfinex () {
	EXCHANGE=$(curl -s $2)
	PRICE=$(echo $EXCHANGE | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$PRICE" ]; do
		EXCHANGE=$(curl -s $2)
		PRICE=$(echo $EXCHANGE | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		printf .
		sleep 5
	done
	MIN=$(echo $EXCHANGE | grep "\"low\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	MAX=$(echo $EXCHANGE | grep "\"high\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BRL=$(echo "scale=3;$PRICE*$3" | bc)
	echo "\033[2K"$1 = $PRICE \($MIN - $MAX\) R\$ $BRL

	local  __resultvar=$4
	local  myresult=$PRICE
	eval $__resultvar="'$myresult'"
}

get_price_negocie () {
	EXCHANGE=$(curl -s $2)
	PRICE=$(echo $EXCHANGE | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$PRICE" ]; do
		NEG=$(curl -s $2)
		PRICE=$(echo $EXCHANGE | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		printf .
		sleep 5
	done
	MIN=$(echo $EXCHANGE | grep -Eo "\"low\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	MAX=$(echo $EXCHANGE | grep -Eo "\"high\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo "\033[2K"$1 = $PRICE \($MIN - $MAX\)

	local  __resultvar=$3
	local  myresult=$PRICE
	eval $__resultvar="'$myresult'"
}

get_price_foxbit () {
	EXCHANGE=$(curl -s $2)
	PRICE=$(echo $EXCHANGE | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$PRICE" ]; do
		EXCHANGE=$(curl -s $2)
		PRICE=$(echo $EXCHANGE | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		printf .
		sleep 5
	done
	MIN=$(echo $EXCHANGE | grep -Eo "\"low\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	MAX=$(echo $EXCHANGE | grep -Eo "\"high\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo "\033[2K"$1 = $PRICE \($MIN - $MAX\)

	local  __resultvar=$3
	local  myresult=$PRICE
	eval $__resultvar="'$myresult'"
}

get_price_coinfloor () {
	EXCHANGE=$(curl -s $2)
	PRICE=$(echo $EXCHANGE | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$PRICE" ]; do
		EXCHANGE=$(curl -s $2)
		PRICE=$(echo $EXCHANGE | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		printf .
		sleep 5
	done
	MIN=$(echo $EXCHANGE | grep -Eo "\"low\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	MAX=$(echo $EXCHANGE | grep -Eo "\"high\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	BRL=$(echo "scale=3;$PRICE*$3" | bc)
	echo "\033[2K"$1 = $PRICE \($MIN - $MAX\) R\$ $BRL

	local  __resultvar=$4
	local  myresult=$PRICE
	eval $__resultvar="'$myresult'"
}

#transferwise exchange rate
# TRWEURBRL=$(curl -s https://transferwise.com/gb/currency-converter/eur-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWGBPBRL=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWUSDBRL=$(curl -s https://transferwise.com/gb/currency-converter/usd-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)

#transferwise fee
TRWFEE=0.02439

	date

	#exchange rate + transferwise fees
	GOOUSDBRL=$(curl -s https://finance.google.com/finance?q=USDBRL | grep  "1 USD = " | grep "?[0-9]*\.[0-9]*" -Eo)
	USDBRL=$(echo "scale=3;($GOOUSDBRL/(1-$TRWFEE))" | bc)
	
	GOOGBPBRL=$(curl -s https://finance.google.com/finance?q=GBPBRL | grep  "1 GBP = " | grep "?[0-9]*\.[0-9]*" -Eo)
	GBPBRL=$(echo "scale=3;($GOOGBPBRL/(1-$TRWFEE))" | bc)
	
	GOOEURBRL=$(curl -s https://finance.google.com/finance?q=EURBRL | grep  "1 EUR = " | grep "?[0-9]*\.[0-9]*" -Eo)
	EURBRL=$(echo "scale=3;($GOOEURBRL/(1-$TRWFEE))" | bc)
	echo "\033[2K"USD = $USDBRL GBP = $GBPBRL EUR = $EURBRL

	# GOOGBPEUR=$(curl -s https://finance.google.com/finance?q=GBPEUR | grep  "1 GBP = " | grep "?[0-9]*\.[0-9]*" -Eo)
	# GBPEUR=$(echo "scale=3;($GOOGBPEUR/(1-$TRWFEE))" | bc)
	# echo GBPEUR = $GBPEUR

	#get rates for GBP->EUR and EUR->USD
	TRWGBPEUR=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-eur-rate?amount=1000 | grep " data-rate=\"EUR\">" | grep "?[0-9]*\.[0-9]*" -Eo)
	TRWEURUSD=$(curl -s https://transferwise.com/gb/currency-converter/eur-to-usd-rate?amount=1000 | grep " data-rate=\"USD\">" | grep "?[0-9]*\.[0-9]*" -Eo)
	echo "\033[2K"GBPEUR = $TRWGBPEUR EURUSD = $TRWEURUSD

	get_price_kraken "KRABTCUSD" "https://api.kraken.com/0/public/Ticker?pair=XBTUSD" "$USDBRL" KRABTCUSD
	get_price_bitfinex "BFNBTCUSD" "https://api.bitfinex.com/v1/pubticker/btcusd" "$USDBRL" BFNBTCUSD
	get_price_kraken "KRABTCEUR" "https://api.kraken.com/0/public/Ticker?pair=XBTEUR" "$EURBRL" KRABTCEUR
	get_price_coinfloor "COIBTCGBP" "https://webapi.coinfloor.co.uk:8090/bist/XBT/GBP/ticker/" "$GBPBRL" COIBTCGBP
	get_price_foxbit "FOXBTCBRL" "https://api.blinktrade.com/api/v1/BRL/ticker" FOXBTCBRL
	get_price_negocie "NEGBTCBRL" "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker" NEGBTCBRL
	echo "\033[2K"-----------------------------
	get_price_kraken "KRABCHUSD" "https://api.kraken.com/0/public/Ticker?pair=BCHUSD" "$USDBRL" KRABCHUSD
	get_price_bitfinex "BFNBCHUSD" "https://api.bitfinex.com/v1/pubticker/bchusd" "$USDBRL" BFNBCHUSD
	get_price_kraken "KRABCHEUR" "https://api.kraken.com/0/public/Ticker?pair=BCHEUR" "$EURBRL" KRABCHEUR
	get_price_negocie "NEGBCHBRL" "https://broker.negociecoins.com.br/api/v3/BCHBRL/ticker" NEGBCHBRL
	echo "\033[2K"-----------------------------
	get_price_kraken "KRAETHUSD" "https://api.kraken.com/0/public/Ticker?pair=ETHUSD" "$USDBRL" KRAETHUSD
	echo "\033[2K"-----------------------------
	get_price_kraken "KRALTCUSD" "https://api.kraken.com/0/public/Ticker?pair=LTCUSD" "$USDBRL" KRALTCUSD
	get_price_bitfinex "BFNLTCUSD" "https://api.bitfinex.com/v1/pubticker/ltcusd" "$USDBRL" BFNLTCUSD
	get_price_negocie "NEGLTCBRL" "https://broker.negociecoins.com.br/api/v3/LTCBRL/ticker" NEGLTCBRL
	echo "\033[2K"-----------------------------
	get_price_bitfinex "BFNXRPUSD" "https://api.bitfinex.com/v1/pubticker/xrpusd" "$USDBRL" BFNXRPUSD
	echo "\033[2K"-----------------------------
	get_price_bitfinex "BFNIOTUSD" "https://api.bitfinex.com/v1/pubticker/iotusd" "$USDBRL" BFNIOTUSD
	echo "\033[2K"-----------------------------
	get_price_bitfinex "BFNBTGUSD" "https://api.bitfinex.com/v1/pubticker/btgusd" "$USDBRL" BFNBTGUSD
	get_price_negocie "NEGBTGBRL" "https://broker.negociecoins.com.br/api/v3/BTGBRL/ticker" NEGBTGBRL
	echo "\033[2K"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	BTCFOXBRLUSD=$(echo "scale=3;$FOXBTCBRL/$KRABTCUSD" | bc)
	BTCNEGBRLUSD=$(echo "scale=3;$NEGBTCBRL/$KRABTCUSD" | bc)
	BTCFOXBRLGBP=$(echo "scale=3;$FOXBTCBRL/$COIBTCGBP" | bc)
	BTCNEGBRLGBP=$(echo "scale=3;$NEGBTCBRL/$COIBTCGBP" | bc)
	BTCFOXBRLEUR=$(echo "scale=3;$FOXBTCBRL/$KRABTCEUR" | bc)
	BTCNEGBRLEUR=$(echo "scale=3;$NEGBTCBRL/$KRABTCEUR" | bc)

	BCHNEGBRLUSD=$(echo "scale=3;$NEGBCHBRL/$KRABCHUSD" | bc)
	BCHNEGBRLEUR=$(echo "scale=3;$NEGBCHBRL/$KRABCHEUR" | bc)

	LTCNEGBRLUSD=$(echo "scale=3;$NEGLTCBRL/$KRALTCUSD" | bc)
	# LTCNEGBRLEUR=$(echo "scale=3;$NEGLTCBRL/$KRALTCEUR" | bc)

	BTGNEGBRLUSD=$(echo "scale=3;$NEGBTGBRL/$BFNBTGUSD" | bc)

	PCTFOXUSD=$(echo "scale=3;100*(($BTCFOXBRLUSD/$USDBRL)-1)" | bc)
	PCTNEGUSD=$(echo "scale=3;100*(($BTCNEGBRLUSD/$USDBRL)-1)" | bc)

	PCTFOXGBP=$(echo "scale=3;100*(($BTCFOXBRLGBP/$GBPBRL)-1)" | bc)
	PCTNEGGBP=$(echo "scale=3;100*(($BTCNEGBRLGBP/$GBPBRL)-1)" | bc)

	PCTFOXEUR=$(echo "scale=3;100*(($BTCFOXBRLEUR/$EURBRL)-1)" | bc)
	PCTNEGEUR=$(echo "scale=3;100*(($BTCNEGBRLEUR/$EURBRL)-1)" | bc)

	PCTFOXEUR=$(echo "scale=3;100*(($BTCFOXBRLEUR/$EURBRL)-1)" | bc)
	PCTNEGEUR=$(echo "scale=3;100*(($BTCNEGBRLEUR/$EURBRL)-1)" | bc)

	PCT_BCH_NEGUSD=$(echo "scale=3;100*(($BCHNEGBRLUSD/$USDBRL)-1)" | bc)
	PCT_BCH_NEGEUR=$(echo "scale=3;100*(($BCHNEGBRLEUR/$EURBRL)-1)" | bc)

	PCT_LTC_NEGUSD=$(echo "scale=3;100*(($LTCNEGBRLUSD/$USDBRL)-1)" | bc)
	# PCT_BCH_NEGEUR=$(echo "scale=3;100*(($BCHNEGBRLEUR/$EURBRL)-1)" | bc)

	PCT_BTG_NEGUSD=$(echo "scale=3;100*(($BTGNEGBRLUSD/$USDBRL)-1)" | bc)

	echo "\033[2K"BTCFOXBRLUSD = $BTCFOXBRLUSD \(${PCTFOXUSD}\%\)
	echo "\033[2K"BTCNEGBRLUSD = $BTCNEGBRLUSD \(${PCTNEGUSD}\%\)

	echo "\033[2K"BTCFOXBRLGBP = $BTCFOXBRLGBP \(${PCTFOXGBP}\%\)
	echo "\033[2K"BTCNEGBRLGBP = $BTCNEGBRLGBP \(${PCTNEGGBP}\%\)

	echo "\033[2K"BTCFOXBRLEUR = $BTCFOXBRLEUR \(${PCTFOXEUR}\%\)
	echo "\033[2K"BTCNEGBRLEUR = $BTCNEGBRLEUR \(${PCTNEGEUR}\%\)
	echo "\033[2K"-----------------------------
	echo "\033[2K"BCHNEGBRLUSD = $BCHNEGBRLUSD \(${PCT_BCH_NEGUSD}\%\)
	echo "\033[2K"BCHNEGBRLEUR = $BCHNEGBRLEUR \(${PCT_BCH_NEGEUR}\%\)
	echo "\033[2K"-----------------------------
	echo "\033[2K"LTCNEGBRLUSD = $LTCNEGBRLUSD \(${PCT_LTC_NEGUSD}\%\)
	echo "\033[2K"-----------------------------
	echo "\033[2K"BTGNEGBRLUSD = $BTGNEGBRLUSD \(${PCT_BTG_NEGUSD}\%\)
	echo "\033[2K"=============================

