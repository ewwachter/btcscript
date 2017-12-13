#!/bin/sh

# echo "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
# printf "\033[1;0f";


#transferwise exchange rate
# TRWEURBRL=$(curl -s https://transferwise.com/gb/currency-converter/eur-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWGBPBRL=$(curl -s https://transferwise.com/gb/currency-converter/gbp-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)
# TRWUSDBRL=$(curl -s https://transferwise.com/gb/currency-converter/usd-to-brl-rate?amount=1000 | grep " data-rate=\"BRL\">" | grep "?[0-9]*\.[0-9]*" -Eo)

#transferwise fee
TRWFEE=0.02439


while [ 1 ]; do
	date

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
	KRABTCUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRABTCUSD" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTUSD)
		KRABTCUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRABTCUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABTCUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABTCUSD_BRL=$(echo "scale=3;$KRABTCUSD*$USDBRL" | bc)
	echo KRABTCUSD = $KRABTCUSD \($KRABTCUSD_MIN - $KRABTCUSD_MAX\) R\$ $KRABTCUSD_BRL

	KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTEUR)
	KRABTCEUR=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRABTCEUR" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=XBTEUR)
		KRABTCEUR=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRABTCEUR_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABTCEUR_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABTCEUR_BRL=$(echo "scale=3;$KRABTCEUR*$EURBRL" | bc)
	echo KRABTCEUR = $KRABTCEUR \($KRABTCEUR_MIN - $KRABTCEUR_MAX\) R\$ $KRABTCEUR_BRL
	
	BFN=$(curl -s  https://api.bitfinex.com/v1/pubticker/btcusd)
	BFNLTCUSD=$(echo $BFN | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$BFNLTCUSD" ]; do
		BFN=$(curl -s  https://api.bitfinex.com/v1/pubticker/btcusd)
		BFNLTCUSD=$(echo $BFN | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	BFNLTCUSD_MIN=$(echo $BFN | grep "\"low\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BFNLTCUSD_MAX=$(echo $BFN | grep "\"high\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BFNLTCUSD_BRL=$(echo "scale=3;$BFNLTCUSD*$USDBRL" | bc)
	echo BFNLTCUSD = $BFNLTCUSD \($BFNLTCUSD_MIN - $BFNLTCUSD_MAX\) R\$ $BFNLTCUSD_BRL

	COI=$(curl -s "https://webapi.coinfloor.co.uk:8090/bist/XBT/GBP/ticker/")
	COIBTCGBP=$(echo $COI | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$COIBTCGBP" ]; do
		COI=$(curl -s "https://webapi.coinfloor.co.uk:8090/bist/XBT/GBP/ticker/")
		COIBTCGBP=$(echo $COI | grep -Eo "\"last\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		sleep 5
	done
	COIBTCGBP_MIN=$(echo $COI | grep -Eo "\"low\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	COIBTCGBP_MAX=$(echo $COI | grep -Eo "\"high\":\"[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	COIBTCGBP_BRL=$(echo "scale=3;$COIBTCGBP*$GBPBRL" | bc)
	echo COIBTCGBP = $COIBTCGBP \($COIBTCGBP_MIN - $COIBTCGBP_MAX\) R\$ $COIBTCGBP_BRL
	
	FOX=$(curl -s "https://api.blinktrade.com/api/v1/BRL/ticker")
	FOXBTCBRL=$(echo $FOX | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$FOXBTCBRL" ]; do
		FOX=$(curl -s "https://api.blinktrade.com/api/v1/BRL/ticker")
		FOXBTCBRL=$(echo $FOX | grep -Eo "\"last\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		sleep 5
	done
	FOXBTCBRL_MIN=$(echo $FOX | grep -Eo "\"low\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	FOXBTCBRL_MAX=$(echo $FOX | grep -Eo "\"high\": [0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo FOXBTCBRL = $FOXBTCBRL \($FOXBTCBRL_MIN - $FOXBTCBRL_MAX\)

	NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker")
	NEGBTCBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$NEGBTCBRL" ]; do
		NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/BTCBRL/ticker")
		NEGBTCBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		sleep 5
	done
	NEGBTCBRL_MIN=$(echo $NEG | grep -Eo "\"low\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	NEGBTCBRL_MAX=$(echo $NEG | grep -Eo "\"high\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo NEGBTCBRL = $NEGBTCBRL \($NEGBTCBRL_MIN - $NEGBTCBRL_MAX\)

	echo -----------------------------

	KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHUSD)
	KRABCHUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRABCHUSD" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHUSD)
		KRABCHUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRABCHUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABCHUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABCHUSD_BRL=$(echo "scale=3;$KRABCHUSD*$USDBRL" | bc)
	echo KRABCHUSD = $KRABCHUSD \($KRABCHUSD_MIN - $KRABCHUSD_MAX\) R\$ $KRABCHUSD_BRL

	KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHEUR)
	KRABCHEUR=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRABCHEUR" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=BCHEUR)
		KRABCHEUR=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRABCHEUR_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABCHEUR_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRABCHEUR_BRL=$(echo "scale=3;$KRABCHEUR*$EURBRL" | bc)
	echo KRABCHEUR = $KRABCHEUR \($KRABCHEUR_MIN - $KRABCHEUR_MAX\) R\$ $KRABCHEUR_BRL

	NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/BCHBRL/ticker")
	NEGBCHBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$NEGBCHBRL" ]; do
		NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/BCHBRL/ticker")
		NEGBCHBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		sleep 5
	done
	NEGBCHBRL_MIN=$(echo $NEG | grep -Eo "\"low\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	NEGBCHBRL_MAX=$(echo $NEG | grep -Eo "\"high\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo NEGBCHBRL = $NEGBCHBRL \($NEGBCHBRL_MIN - $NEGBCHBRL_MAX\)

	echo -----------------------------

	KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=ETHUSD)
	KRAETHUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRAETHUSD" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=ETHUSD)
		KRAETHUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRAETHUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRAETHUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRAETHUSD_BRL=$(echo "scale=3;$KRAETHUSD*$USDBRL" | bc)
	echo KRAETHUSD = $KRAETHUSD \($KRAETHUSD_MIN - $KRAETHUSD_MAX\) R\$ $KRAETHUSD_BRL

	echo -----------------------------

	KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=LTCUSD)
	KRALTCUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$KRALTCUSD" ]; do
		KRA=$(curl -s  https://api.kraken.com/0/public/Ticker?pair=LTCUSD)
		KRALTCUSD=$(echo $KRA | grep "\"c\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	KRALTCUSD_MIN=$(echo $KRA | grep "\"l\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRALTCUSD_MAX=$(echo $KRA | grep "\"h\":\[\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	KRALTCUSD_BRL=$(echo "scale=3;$KRALTCUSD*$USDBRL" | bc)
	echo KRALTCUSD = $KRALTCUSD \($KRALTCUSD_MIN - $KRALTCUSD_MAX\) R\$ $KRALTCUSD_BRL

	BFN=$(curl -s  https://api.bitfinex.com/v1/pubticker/ltcusd)
	BFNLTCUSD=$(echo $BFN | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	while [ -z "$BFNLTCUSD" ]; do
		BFN=$(curl -s  https://api.bitfinex.com/v1/pubticker/ltcusd)
		BFNLTCUSD=$(echo $BFN | grep "\"last_price\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
		sleep 5
	done
	BFNLTCUSD_MIN=$(echo $BFN | grep "\"low\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BFNLTCUSD_MAX=$(echo $BFN | grep "\"high\":\"?[0-9]*\.?[0-9]{1}" -Eo | grep "?[0-9]*\.?[0-9]*" -Eo)
	BFNLTCUSD_BRL=$(echo "scale=3;$BFNLTCUSD*$USDBRL" | bc)
	echo BFNLTCUSD = $BFNLTCUSD \($BFNLTCUSD_MIN - $BFNLTCUSD_MAX\) R\$ $BFNLTCUSD_BRL

	NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/LTCBRL/ticker")
	NEGLTCBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	while [ -z "$NEGLTCBRL" ]; do
		NEG=$(curl -s "https://broker.negociecoins.com.br/api/v3/LTCBRL/ticker")
		NEGLTCBRL=$(echo $NEG | grep -Eo "\"last\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
		sleep 5
	done
	NEGLTCBRL_MIN=$(echo $NEG | grep -Eo "\"low\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	NEGLTCBRL_MAX=$(echo $NEG | grep -Eo "\"high\":[0-9]{1,5}.[0-9]" | grep -Eo "[0-9]{1,5}.[0-9]")
	echo NEGLTCBRL = $NEGLTCBRL \($NEGLTCBRL_MIN - $NEGLTCBRL_MAX\)

	echo -----------------------------

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

	echo BTCFOXBRLUSD = $BTCFOXBRLUSD \(${PCTFOXUSD}\%\)
	echo BTCNEGBRLUSD = $BTCNEGBRLUSD \(${PCTNEGUSD}\%\)

	echo BTCFOXBRLGBP = $BTCFOXBRLGBP \(${PCTFOXGBP}\%\)
	echo BTCNEGBRLGBP = $BTCNEGBRLGBP \(${PCTNEGGBP}\%\)

	echo BTCFOXBRLEUR = $BTCFOXBRLEUR \(${PCTFOXEUR}\%\)
	echo BTCNEGBRLEUR = $BTCNEGBRLEUR \(${PCTNEGEUR}\%\)
	echo -----------------------------
	echo BCHNEGBRLUSD = $BCHNEGBRLUSD \(${PCT_BCH_NEGUSD}\%\)
	echo BCHNEGBRLEUR = $BCHNEGBRLEUR \(${PCT_BCH_NEGEUR}\%\)
	echo -----------------------------
	echo LTCNEGBRLUSD = $LTCNEGBRLUSD \(${PCT_LTC_NEGUSD}\%\)
	# echo LTCNEGBRLEUR = $BCHNEGBRLEUR \(${PCT_BCH_NEGEUR}\%\)
	echo =============================

	#go to te corner of screen
	# printf "\033[0;0f";
	#Move the cursor up 34 lines:
	printf "\033[34A"
	# Move the cursor backward 28 columns:
	# printf "\033[28"

	sleep 60
done




