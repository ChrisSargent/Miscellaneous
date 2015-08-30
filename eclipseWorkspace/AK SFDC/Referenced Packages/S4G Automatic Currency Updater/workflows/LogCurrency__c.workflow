<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>CallCurrencyUpdater</fullName>
        <apiVersion>24.0</apiVersion>
        <endpointUrl>http://currencyupdater2.appspot.com/currency_updater_2_0</endpointUrl>
        <fields>Id</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>chris@akascia.com</integrationUser>
        <name>CallCurrencyUpdater</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>RunCurrencyUpdater</fullName>
        <actions>
            <name>CallCurrencyUpdater</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LogCurrency__c.Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
