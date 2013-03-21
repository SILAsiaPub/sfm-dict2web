// JavaScript Document
window.onload=function() {
	var URLParts=window.location.toString().split('#');
	if(URLParts.length>1)
		var lastPage=decodeURI(URLParts[1]);
	else
		return false;
	if(lastPage)
		iframe_load(lastPage,'content');
}
function clear_last_page(location) {
	var URLParts=location.split('#');
	if(URLParts.length<=1)
		return location;
	URLParts.pop();
	return URLParts.join('#');
}
function iframe_load(url,targetID) {
	document.getElementById(targetID).src=url;
	var location=clear_last_page(window.location.toString())+'#'+url;
	window.location.href=location;
}