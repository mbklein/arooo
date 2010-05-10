// ==UserScript==
// @name           WW Vote Counts
// @namespace      http://userscripts.org/users/107369
// @description    Displays a floating div with linked, bolded votes
// @include        http://www.mainsquare.org/showthread.php?*
// ==/UserScript==

function harvestVotes() {
  var result = '';
  var voteRe = new RegExp("(unvote|vote\\s+(.+))","gmi");

  var xpathResult = document.evaluate('//div[@class="vb_postbit"]/b', document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
  for (var i = 0; i < xpathResult.snapshotLength; i++) {
    var node = xpathResult.snapshotItem(i);
    var text = node.textContent.replace(/\n/g,' ');
    var voteContent = text.match(voteRe);
    if (voteContent != null) {
      var who = document.evaluate('./ancestor::tr/td[@class="userinfo_bg"]//a[@class="bigusername"]', node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0);
      var post = document.evaluate('./ancestor::table/@id', node, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null).snapshotItem(0);
      for (var j = 0; j < voteContent.length; j++) {
        if (voteContent[j].toLowerCase() != 'vote count') {
          result += '<li>' + who.textContent + ': <a href="#' + post.value + '"><b>' + voteContent[j] + '</b></a></li>';
        }
      }
    }
  }
  if (result != '') {
    return '<ul>' + result + '</ul>';
  } else {
    return null;
  }
}

function displayVotes() {
  var votes = harvestVotes();
  if (votes != null) {
    var styleSheet = document.createElement('style');
    styleSheet.type = 'text/css';
    styleSheet.innerHTML = '\
#voting_action_container { \
  width: auto; \
  position: fixed; \
  top: 2em; \
  right: 2em; \
  left: auto; \
  padding: 0 0.75em; \
  background: yellow; \
  white-space: nowrap; \
} \
\
#voting_action_container ul { \
  list-style-type: none; \
  padding-left: 0; \
}';
    document.getElementsByTagName('head')[0].appendChild(styleSheet);
    
    var newDiv = document.createElement('div');
    var newScript = document.createElement('script');
    newScript.type = 'text/javascript';
    newScript.innerHTML = "\
var votesShowing = true; \
function toggleVotes() { \
  document.getElementById('voting_action').style.display = (votesShowing ? 'none' : 'block'); \
  document.getElementById('voting_action_toggle').style.display = (votesShowing ? 'block' : 'none'); \
  votesShowing = !votesShowing; \
  void(0); \
}";
    newDiv.appendChild(newScript);

    newDiv.id = 'voting_action_container';
    var childDiv = document.createElement('div');
    childDiv.id = 'voting_action_toggle';
    childDiv.style.display = 'none';
    childDiv.innerHTML = '<p><b>Voting action on this page:</b> (<a href="javascript:toggleVotes();">show</a>)</p>';
    newDiv.appendChild(childDiv);

    childDiv = document.createElement('div');
    childDiv.id = 'voting_action';
    childDiv.style.display = 'block';
    childDiv.innerHTML = '<p><b>Voting action on this page:</b> (<a href="javascript:toggleVotes();">hide</a>)</p>' + votes;
    newDiv.appendChild(childDiv);
    
    document.body.insertBefore(newDiv, document.body.firstChild);
  }
}

window.addEventListener("load", function() { displayVotes(); }, true);
