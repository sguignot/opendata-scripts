#!/bin/sh

if test $# -ne 1; then
	echo "Usage: $0 input.html"
	exit 1
fi

xmlstarlet sel -T -t -v "concat(\
//ix:nonNumeric[contains(@name,'UKCompaniesHouseRegisteredNumber')],';',\
//ix:nonNumeric[contains(@name,'BalanceSheetDate')],';',\
//ix:nonNumeric[contains(@name,'BalanceSheetDate')]/@format,';',\
//ix:nonNumeric[contains(@name,'StartDateForPeriodCoveredByReport')],';',\
//ix:nonNumeric[contains(@name,'StartDateForPeriodCoveredByReport')]/@format,';',\
//ix:nonNumeric[contains(@name,'EndDateForPeriodCoveredByReport')],';',\
//ix:nonNumeric[contains(@name,'EndDateForPeriodCoveredByReport')]/@format,';',\
//ix:nonNumeric[contains(@name,'EntityDormant')],';',\
//ix:nonNumeric[contains(@name,'EntityTrading')],';',\
//ix:nonNumeric[contains(@name,'CompanyHasActedAsAnAgentDuringPeriod')],';',\
//ix:nonFraction[@name='uk-gaap-pt:ShareholderFunds' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:ShareholderFunds' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap-pt:NetAssetsLiabilitiesIncludingPensionAssetLiability' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:NetAssetsLiabilitiesIncludingPensionAssetLiability' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap-pt:CashBankInHand' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:CashBankInHand' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap-pt:TotalAssetsLessCurrentLiabilities' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:TotalAssetsLessCurrentLiabilities' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap-pt:NetCurrentAssetsLiabilities' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:NetCurrentAssetsLiabilities' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap-pt:CurrentAssets' and @contextRef='current-mud']/@sign,//ix:nonFraction[@name='uk-gaap-pt:CurrentAssets' and @contextRef='current-mud'],';',\
//ix:nonFraction[@name='uk-gaap:ProfitLossForPeriod' and @contextRef='CY']/@sign,//ix:nonFraction[@name='uk-gaap:ProfitLossForPeriod' and @contextRef='CY'],';',\
//ix:nonFraction[@name='uk-gaap:TurnoverGrossOperatingRevenue' and @contextRef='CY']/@sign,//ix:nonFraction[@name='uk-gaap:TurnoverGrossOperatingRevenue' and @contextRef='CY'],';')\
" -f -n "$1"
