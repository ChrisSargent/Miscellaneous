from twilio.rest import TwilioRestClient
 
# Your Account Sid and Auth Token from twilio.com/user/account
account_sid = "ACd030416124351fb440562bf659ce94e9"
auth_token  = "16a165d427012722ff156763ebf3bdba"
client = TwilioRestClient(account_sid, auth_token)
 
message = client.messages.create(body="Hello Christopher!",
    to="+33652151300",    # Replace with your phone number
    from_="+14154187870") # Replace with your Twilio number
print message.sid
