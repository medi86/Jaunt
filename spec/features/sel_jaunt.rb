<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head profile="http://selenium-ide.openqa.org/profiles/test-case">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="selenium.base" href="http://localhost:3000/" />
<title>user can make a jaunt</title>
</head>
<body>
<table cellpadding="1" cellspacing="1" border="1">
<thead>
<tr><td rowspan="1" colspan="3">user can make a jaunt</td></tr>
</thead><tbody>
<tr>
	<td>open</td>
	<td>http://localhost:3000/</td>
	<td></td>
</tr>
<tr>
	<td>clickAndWait</td>
	<td>link=Log-In</td>
	<td></td>
</tr>
<tr>
	<td>type</td>
	<td>id=session_email</td>
	<td>medi8600@gmail.com</td>
</tr>
<tr>
	<td>type</td>
	<td>id=session_password</td>
	<td>asdf1234</td>
</tr>
<tr>
	<td>clickAndWait</td>
	<td>name=commit</td>
	<td></td>
</tr>
<tr>
	<td>clickAndWait</td>
	<td>link=Create Jaunts</td>
	<td></td>
</tr>
<tr>
	<td>type</td>
	<td>id=jaunt-title-text</td>
	<td>test</td>
</tr>
<tr>
	<td>type</td>
	<td>id=jaunt-desc-text</td>
	<td>test</td>
</tr>
<tr>
	<td>sendKeys</td>
	<td>id=addLocation</td>
	<td>adsf</td>
</tr>
<tr>
	<td>pause</td>
	<td>500</td>
	<td></td>
</tr>
<tr>
	<td>doubleClickAt</td>
	<td>id=addLocation</td>
	<td></td>
</tr>
<tr>
	<td>keyDown</td>
	<td>id=addLocation</td>
	<td>\40</td>
</tr>
<tr>
	<td>keyDown</td>
	<td>id=addLocation</td>
	<td>\13</td>
</tr>
<tr>
	<td>sendKeys</td>
	<td>id=location-0-text</td>
	<td>test</td>
</tr>
<tr>
	<td>clickAndWait</td>
	<td>css=input.btn.btn-warning</td>
	<td></td>
</tr>
<tr>
	<td>verifyText</td>
	<td>css=div.alert.alert-success</td>
	<td>New jaunt! Thank you!</td>
</tr>
</tbody></table>
</body>
</html>
