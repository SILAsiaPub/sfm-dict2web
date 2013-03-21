// JavaScript Document
// JavaScript Document
// Original:  Dion (biab@iinet.net.au)
// Web Site:  http://www.iinet.net.au/~biab 
// The JavaScript Source!! http://javascript.internet.com
// Modified from script found at the above url

function search(frm) {

    var results = ""
    results += '<div class="index">';
    var searchArr = frm.srchval.value.toLowerCase().split(" ");
    var resultsArr = new Array();
    var total = 0;
    //For each search item array
    for (i = 0; i < lx[0].length; i++) {
        var score = 0;
        //The scoring method (lowest valued to highest)
            //for each word to be searched
            for (k = 0; k < searchArr.length; k++) {
                if (lx[0][i].toLowerCase().indexOf(searchArr[k]) > -1 && searchArr[k] != "") {
                    //Put the score in the results array
                    score += ( searchArr.length - k );
                }
            }

        //If the score is > 0 (ie. a word was found in the item)
        if (score > 0) {
            //Add the item to the results
            var searchItem = new Object();
            searchItem.index = i;
            searchItem.score = score;
            searchItem.head_word = lx[0][i];
//            searchItem.content = lx[i];
            resultsArr.push(searchItem);
        }
    }

    resultsArr.sort(compareScoreDesc);

    results += "<h4>Total found: " + resultsArr.length + "</h4>";

    //for each matched item
    for (i = 0; i < resultsArr.length; i++) {
        results += getRowResult(resultsArr[i]);
    }

    results += "</div>";
   parent.index.document.getElementById("results").innerHTML = results;
    document.form_search.srchval.select();
}

function getRowResult(item) {
    link = '../lexicon/lx' + pad_left(item.index, '0', 5) + ".html";
    line = "<a href='" + link + "' target='lexicon'>" + item.head_word + "</a><br />";
//    line += item.content + "</td></tr>";
    return line;
}


//  End -->

function pad_left(str, chr, length) {
    str++
    var newStr = '' + str;
    while (newStr.length < length) {
        newStr = chr + newStr;
    }
    return newStr;
}

function compareScoreDesc(a, b) {
    return b.score - a.score;
}
function highlightwords(string, arrayname) {
    oldStr = string
    hlarray = new Array(arrayname)
    for (s = 0; s < arrayname.lenght; s++) {
        newStr = oldStr.replace(hlarray[s], "<em>" + hlarray[s] + "</em>")
    }
    return newStr;
}
