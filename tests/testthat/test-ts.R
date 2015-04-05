


<!DOCTYPE html>
<html lang="en" class="">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    
    
    <title>AnomalyDetection/test-ts.R at master · jhochenbaum/AnomalyDetection</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="jhochenbaum/AnomalyDetection" name="twitter:title" /><meta content="AnomalyDetection - Anomaly Detection with R" name="twitter:description" /><meta content="https://avatars3.githubusercontent.com/u/908243?v=3&amp;s=400" name="twitter:image:src" />
      <meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars3.githubusercontent.com/u/908243?v=3&amp;s=400" property="og:image" /><meta content="jhochenbaum/AnomalyDetection" property="og:title" /><meta content="https://github.com/jhochenbaum/AnomalyDetection" property="og:url" /><meta content="AnomalyDetection - Anomaly Detection with R" property="og:description" />
      <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">
    <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">
    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="web-socket" href="wss://live.github.com/_sockets/OTM0MjcwMjo0YzhhMDI5Yjk2YjhmYjk1NGJiYzNjODk4MjgwMzY2NjpjNmRmMGY2MzE0ZTM2NTA4ZDA2MjhmYmUyOGEyODYzZTZkNmJhZGZjNTE5YjczNGIzZjY5ZGI5M2QxNGNhNGM1--6cd0ec4efa25811bdfb75fde18a61d7622c88318">
    <meta name="pjax-timeout" content="1000">
    <link rel="sudo-modal" href="/sessions/sudo_modal">

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="4CFE3AFD:7843:B684CE:5521B73B" name="octolytics-dimension-request_id" /><meta content="9342702" name="octolytics-actor-id" /><meta content="akejariwal" name="octolytics-actor-login" /><meta content="1a744999c9ec487a43eeccfcf5fe3c742243bd811d95e85a0181c6a666c9ca6d" name="octolytics-actor-hash" />
    
    <meta content="Rails, view, blob#show" name="analytics-event" />
    <meta class="js-ga-set" name="dimension1" content="Logged In">
    <meta class="js-ga-set" name="dimension2" content="Header v3">
    <meta name="is-dotcom" content="true">
    <meta name="hostname" content="github.com">
    <meta name="user-login" content="akejariwal">

    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">


    <meta content="authenticity_token" name="csrf-param" />
<meta content="tMZzb0PIFnQYMkJ7bIYVPH1F8ELxk5/at7aHSFgiscO0SBzNVkoBb1jiu7zlLf73bkuj+HMhy+kevKfG1pb5cw==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-b9a6ff74be89fc3bd0700145f09893176e0217b525876169a377b19cc4434e53.css" media="all" rel="stylesheet" />
    <link href="https://assets-cdn.github.com/assets/github2-845567e50e6a49a7716ad7599fb42ba9d88ea7735afca5afed1d040e48deaf9d.css" media="all" rel="stylesheet" />
    
    


    <meta http-equiv="x-pjax-version" content="d03d6cdbd3eb435e62c62ab826617f16">

      
  <meta name="description" content="AnomalyDetection - Anomaly Detection with R">
  <meta name="go-import" content="github.com/jhochenbaum/AnomalyDetection git https://github.com/jhochenbaum/AnomalyDetection.git">

  <meta content="908243" name="octolytics-dimension-user_id" /><meta content="jhochenbaum" name="octolytics-dimension-user_login" /><meta content="29151320" name="octolytics-dimension-repository_id" /><meta content="jhochenbaum/AnomalyDetection" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="true" name="octolytics-dimension-repository_is_fork" /><meta content="27778839" name="octolytics-dimension-repository_parent_id" /><meta content="twitter/AnomalyDetection" name="octolytics-dimension-repository_parent_nwo" /><meta content="27778839" name="octolytics-dimension-repository_network_root_id" /><meta content="twitter/AnomalyDetection" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/jhochenbaum/AnomalyDetection/commits/master.atom" rel="alternate" title="Recent Commits to AnomalyDetection:master" type="application/atom+xml">

  </head>


  <body class="logged_in  env-production macintosh vis-public fork page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      


        <div class="header header-logged-in true" role="banner">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/" data-hotkey="g d" aria-label="Homepage" data-ga-click="Header, go to dashboard, icon:logo">
  <span class="mega-octicon octicon-mark-github"></span>
</a>


      <div class="site-search repo-scope js-site-search" role="search">
          <form accept-charset="UTF-8" action="/jhochenbaum/AnomalyDetection/search" class="js-site-search-form" data-global-search-url="/search" data-repo-search-url="/jhochenbaum/AnomalyDetection/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
  <input type="text"
    class="js-site-search-field is-clearable"
    data-hotkey="s"
    name="q"
    placeholder="Search"
    data-global-scope-placeholder="Search GitHub"
    data-repo-scope-placeholder="Search"
    tabindex="1"
    autocapitalize="off">
  <div class="scope-badge">This repository</div>
</form>
      </div>

      <ul class="header-nav left" role="navigation">
          <li class="header-nav-item explore">
            <a class="header-nav-link" href="/explore" data-ga-click="Header, go to explore, text:explore">Explore</a>
          </li>
            <li class="header-nav-item">
              <a class="header-nav-link" href="https://gist.github.com" data-ga-click="Header, go to gist, text:gist">Gist</a>
            </li>
            <li class="header-nav-item">
              <a class="header-nav-link" href="/blog" data-ga-click="Header, go to blog, text:blog">Blog</a>
            </li>
          <li class="header-nav-item">
            <a class="header-nav-link" href="https://help.github.com" data-ga-click="Header, go to help, text:help">Help</a>
          </li>
      </ul>

      
<ul class="header-nav user-nav right" id="user-links">
  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link name" href="/akejariwal" data-ga-click="Header, go to profile, text:username">
      <img alt="@akejariwal" class="avatar" data-user="9342702" height="20" src="https://avatars2.githubusercontent.com/u/9342702?v=3&amp;s=40" width="20" />
      <span class="css-truncate">
        <span class="css-truncate-target">akejariwal</span>
      </span>
    </a>
  </li>

  <li class="header-nav-item dropdown js-menu-container">
    <a class="header-nav-link js-menu-target tooltipped tooltipped-s" href="#" aria-label="Create new..." data-ga-click="Header, create new, icon:add">
      <span class="octicon octicon-plus"></span>
      <span class="dropdown-caret"></span>
    </a>

    <div class="dropdown-menu-content js-menu-content">
      <ul class="dropdown-menu">
        
<li>
  <a href="/new" data-ga-click="Header, create new repository, icon:repo"><span class="octicon octicon-repo"></span> New repository</a>
</li>
<li>
  <a href="/organizations/new" data-ga-click="Header, create new organization, icon:organization"><span class="octicon octicon-organization"></span> New organization</a>
</li>



      </ul>
    </div>
  </li>

  <li class="header-nav-item">
        <a href="/notifications" aria-label="You have unread notifications" class="header-nav-link notification-indicator tooltipped tooltipped-s" data-ga-click="Header, go to notifications, icon:unread" data-hotkey="g n">
        <span class="mail-status unread"></span>
        <span class="octicon octicon-inbox"></span>
</a>
  </li>

  <li class="header-nav-item">
    <a class="header-nav-link tooltipped tooltipped-s" href="/settings/profile" id="account_settings" aria-label="Settings" data-ga-click="Header, go to settings, icon:settings">
      <span class="octicon octicon-gear"></span>
    </a>
  </li>

  <li class="header-nav-item">
    <form accept-charset="UTF-8" action="/logout" class="logout-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="MYBERf5Tay2yRslNr0JOF+OIX9LxV37Ml4pQ3A+jMYpE7yelx+S/fjzqxjwAEzMVkOxWaaEIlKjraLpqOA8Otg==" /></div>
      <button class="header-nav-link sign-out-button tooltipped tooltipped-s" aria-label="Sign out" data-ga-click="Header, sign out, icon:logout">
        <span class="octicon octicon-sign-out"></span>
      </button>
</form>  </li>

</ul>



    
  </div>
</div>

        

        


      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        
<ul class="pagehead-actions">

  <li>
      <form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="M5yupxDFqHoxbJ1588RQXaTqrmkJQA1HnghLXwbyRfswBgcx9/Gq9rCPWowBdD9EifsspQiqH/c9BIbOgaEM6w==" /></div>    <input id="repository_id" name="repository_id" type="hidden" value="29151320" />

      <div class="select-menu js-menu-container js-select-menu">
        <a href="/jhochenbaum/AnomalyDetection/subscription"
          class="btn btn-sm btn-with-count select-menu-button js-menu-target" role="button" tabindex="0" aria-haspopup="true"
          data-ga-click="Repository, click Watch settings, action:blob#show">
          <span class="js-select-button">
            <span class="octicon octicon-eye"></span>
            Watch
          </span>
        </a>
        <a class="social-count js-social-count" href="/jhochenbaum/AnomalyDetection/watchers">
          1
        </a>

        <div class="select-menu-modal-holder">
          <div class="select-menu-modal subscription-menu-modal js-menu-content" aria-hidden="true">
            <div class="select-menu-header">
              <span class="select-menu-title">Notifications</span>
              <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
            </div>

            <div class="select-menu-list js-navigation-container" role="menu">

              <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
                <span class="select-menu-item-icon octicon octicon-check"></span>
                <div class="select-menu-item-text">
                  <input checked="checked" id="do_included" name="do" type="radio" value="included" />
                  <span class="select-menu-item-heading">Not watching</span>
                  <span class="description">Be notified when participating or @mentioned.</span>
                  <span class="js-select-button-text hidden-select-button-text">
                    <span class="octicon octicon-eye"></span>
                    Watch
                  </span>
                </div>
              </div>

              <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
                <span class="select-menu-item-icon octicon octicon octicon-check"></span>
                <div class="select-menu-item-text">
                  <input id="do_subscribed" name="do" type="radio" value="subscribed" />
                  <span class="select-menu-item-heading">Watching</span>
                  <span class="description">Be notified of all conversations.</span>
                  <span class="js-select-button-text hidden-select-button-text">
                    <span class="octicon octicon-eye"></span>
                    Unwatch
                  </span>
                </div>
              </div>

              <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
                <span class="select-menu-item-icon octicon octicon-check"></span>
                <div class="select-menu-item-text">
                  <input id="do_ignore" name="do" type="radio" value="ignore" />
                  <span class="select-menu-item-heading">Ignoring</span>
                  <span class="description">Never be notified.</span>
                  <span class="js-select-button-text hidden-select-button-text">
                    <span class="octicon octicon-mute"></span>
                    Stop ignoring
                  </span>
                </div>
              </div>

            </div>

          </div>
        </div>
      </div>
</form>
  </li>

  <li>
    
  <div class="js-toggler-container js-social-container starring-container ">

    <form accept-charset="UTF-8" action="/jhochenbaum/AnomalyDetection/unstar" class="js-toggler-form starred js-unstar-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="G9arv4yoeHqvzR+B5Z6kwbLofuEPzPdEJMK/w6gbYkAesULsF5EYSAA1JvtL4LZxDwUg7NQsojS8Ao8DdbIwmg==" /></div>
      <button
        class="btn btn-sm btn-with-count js-toggler-target"
        aria-label="Unstar this repository" title="Unstar jhochenbaum/AnomalyDetection"
        data-ga-click="Repository, click unstar button, action:blob#show; text:Unstar">
        <span class="octicon octicon-star"></span>
        Unstar
      </button>
        <a class="social-count js-social-count" href="/jhochenbaum/AnomalyDetection/stargazers">
          0
        </a>
</form>
    <form accept-charset="UTF-8" action="/jhochenbaum/AnomalyDetection/star" class="js-toggler-form unstarred js-star-button" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="bQRAT8jDHYzJmlKDN3dpQO8RLN/KsLykLImnA5zrVYaLPpYBgmT7NMeyGTC6iCqPkMYa2qSAqI0HgYImN13KqQ==" /></div>
      <button
        class="btn btn-sm btn-with-count js-toggler-target"
        aria-label="Star this repository" title="Star jhochenbaum/AnomalyDetection"
        data-ga-click="Repository, click star button, action:blob#show; text:Star">
        <span class="octicon octicon-star"></span>
        Star
      </button>
        <a class="social-count js-social-count" href="/jhochenbaum/AnomalyDetection/stargazers">
          0
        </a>
</form>  </div>

  </li>

        <li>
          <a href="#fork-destination-box" class="btn btn-sm btn-with-count"
              title="Fork your own copy of jhochenbaum/AnomalyDetection to your account"
              aria-label="Fork your own copy of jhochenbaum/AnomalyDetection to your account"
              rel="facebox"
              data-ga-click="Repository, show fork modal, action:blob#show; text:Fork">
            <span class="octicon octicon-repo-forked"></span>
            Fork
          </a>
          <a href="/jhochenbaum/AnomalyDetection/network" class="social-count">118</a>

          <div id="fork-destination-box" style="display: none;">
            <h2 class="facebox-header">Where should we fork this repository?</h2>
            <include-fragment src=""
                class="js-fork-select-fragment fork-select-fragment"
                data-url="/jhochenbaum/AnomalyDetection/fork?fragment=1">
              <img alt="Loading" height="64" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-128-338974454bb5c32803e82f601beb051d373744b024fe8742a76009700fd7e033.gif" width="64" />
            </include-fragment>
          </div>
        </li>

</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="mega-octicon octicon-repo-forked"></span>
          <span class="author"><a href="/jhochenbaum" class="url fn" itemprop="url" rel="author"><span itemprop="title">jhochenbaum</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/jhochenbaum/AnomalyDetection" class="js-current-repository" data-pjax="#js-repo-pjax-container">AnomalyDetection</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-e513294efa576953719e4e2de888dd9cf929b7d62ed8d05f25e731d02452ab6c.gif" width="16" />
          </span>

            <span class="fork-flag">
              <span class="text">forked from <a href="/twitter/AnomalyDetection">twitter/AnomalyDetection</a></span>
            </span>
        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            
<nav class="sunken-menu repo-nav js-repo-nav js-sidenav-container-pjax js-octicon-loaders"
     role="navigation"
     data-pjax="#js-repo-pjax-container"
     data-issue-count-url="/jhochenbaum/AnomalyDetection/issues/counts">
  <ul class="sunken-menu-group">
    <li class="tooltipped tooltipped-w" aria-label="Code">
      <a href="/jhochenbaum/AnomalyDetection" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /jhochenbaum/AnomalyDetection">
        <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-e513294efa576953719e4e2de888dd9cf929b7d62ed8d05f25e731d02452ab6c.gif" width="16" />
</a>    </li>


    <li class="tooltipped tooltipped-w" aria-label="Pull requests">
      <a href="/jhochenbaum/AnomalyDetection/pulls" aria-label="Pull requests" class="js-selected-navigation-item sunken-menu-item" data-hotkey="g p" data-selected-links="repo_pulls /jhochenbaum/AnomalyDetection/pulls">
          <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull requests</span>
          <span class="js-pull-replace-counter"></span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-e513294efa576953719e4e2de888dd9cf929b7d62ed8d05f25e731d02452ab6c.gif" width="16" />
</a>    </li>

  </ul>
  <div class="sunken-menu-separator"></div>
  <ul class="sunken-menu-group">

    <li class="tooltipped tooltipped-w" aria-label="Pulse">
      <a href="/jhochenbaum/AnomalyDetection/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-selected-links="pulse /jhochenbaum/AnomalyDetection/pulse">
        <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-e513294efa576953719e4e2de888dd9cf929b7d62ed8d05f25e731d02452ab6c.gif" width="16" />
</a>    </li>

    <li class="tooltipped tooltipped-w" aria-label="Graphs">
      <a href="/jhochenbaum/AnomalyDetection/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-selected-links="repo_graphs repo_contributors /jhochenbaum/AnomalyDetection/graphs">
        <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
        <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-e513294efa576953719e4e2de888dd9cf929b7d62ed8d05f25e731d02452ab6c.gif" width="16" />
</a>    </li>
  </ul>


</nav>

              <div class="only-with-full-nav">
                  
<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><span class="text-emphasized">HTTPS</span> clone URL</h3>
  <div class="input-group js-zeroclipboard-container">
    <input type="text" class="input-mini input-monospace js-url-field js-zeroclipboard-target"
           value="https://github.com/jhochenbaum/AnomalyDetection.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard btn btn-sm zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=clone">
  <h3><span class="text-emphasized">SSH</span> clone URL</h3>
  <div class="input-group js-zeroclipboard-container">
    <input type="text" class="input-mini input-monospace js-url-field js-zeroclipboard-target"
           value="git@github.com:jhochenbaum/AnomalyDetection.git" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard btn btn-sm zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  
<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><span class="text-emphasized">Subversion</span> checkout URL</h3>
  <div class="input-group js-zeroclipboard-container">
    <input type="text" class="input-mini input-monospace js-url-field js-zeroclipboard-target"
           value="https://github.com/jhochenbaum/AnomalyDetection" readonly="readonly">
    <span class="input-group-button">
      <button aria-label="Copy to clipboard" class="js-zeroclipboard btn btn-sm zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>



<p class="clone-options">You can clone with
  <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>, <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>, or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <a href="https://help.github.com/articles/which-remote-url-should-i-use" class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <span class="octicon octicon-question"></span>
  </a>
</p>

  <a href="https://mac.github.com" class="btn btn-sm sidebar-button" title="Save jhochenbaum/AnomalyDetection to your computer and use it in GitHub Desktop." aria-label="Save jhochenbaum/AnomalyDetection to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>


                <a href="/jhochenbaum/AnomalyDetection/archive/master.zip"
                   class="btn btn-sm sidebar-button"
                   aria-label="Download the contents of jhochenbaum/AnomalyDetection as a zip file"
                   title="Download the contents of jhochenbaum/AnomalyDetection as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/jhochenbaum/AnomalyDetection/blob/4c00cf9d2720d4e5c53a984092d1dc7ac75b62b3/tests/testthat/test-ts.R" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:3c3fe5b5235ecee478564e7c89368e05 -->

<div class="file-navigation js-zeroclipboard-container">
  
<div class="select-menu js-menu-container js-select-menu left">
  <span class="btn btn-sm select-menu-button js-menu-target css-truncate" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    title="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close" role="button" aria-label="Close"></span>
      </div>

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" data-filter-placeholder="Filter branches/tags" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" data-filter-placeholder="Find a tag…" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <a class="select-menu-item js-navigation-item js-navigation-open selected"
               href="/jhochenbaum/AnomalyDetection/blob/master/tests/testthat/test-ts.R"
               data-name="master"
               data-skip-pjax="true"
               rel="nofollow">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <span class="select-menu-item-text css-truncate-target" title="master">
                master
              </span>
            </a>
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jhochenbaum/AnomalyDetection/tree/v1.0.1/tests/testthat/test-ts.R"
                 data-name="v1.0.1"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v1.0.1">v1.0.1</a>
            </div>
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jhochenbaum/AnomalyDetection/tree/v1.0.0/tests/testthat/test-ts.R"
                 data-name="v1.0.0"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text css-truncate-target"
                 title="v1.0.0">v1.0.0</a>
            </div>
        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div>

    </div>
  </div>
</div>

  <div class="btn-group right">
    <a href="/jhochenbaum/AnomalyDetection/find/master"
          class="js-show-file-finder btn btn-sm empty-icon tooltipped tooltipped-s"
          data-pjax
          data-hotkey="t"
          aria-label="Quickly jump between files">
      <span class="octicon octicon-list-unordered"></span>
    </a>
    <button aria-label="Copy file path to clipboard" class="js-zeroclipboard btn btn-sm zeroclipboard-button" data-copied-hint="Copied!" type="button"><span class="octicon octicon-clippy"></span></button>
  </div>

  <div class="breadcrumb js-zeroclipboard-target">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jhochenbaum/AnomalyDetection" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">AnomalyDetection</span></a></span></span><span class="separator">/</span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jhochenbaum/AnomalyDetection/tree/master/tests" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">tests</span></a></span><span class="separator">/</span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jhochenbaum/AnomalyDetection/tree/master/tests/testthat" class="" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">testthat</span></a></span><span class="separator">/</span><strong class="final-path">test-ts.R</strong>
  </div>
</div>

<include-fragment class="commit commit-loader file-history-tease" src="/jhochenbaum/AnomalyDetection/contributors/master/tests/testthat/test-ts.R">
  <div class="file-history-tease-header">
    Fetching contributors&hellip;
  </div>

  <div class="participation">
    <p class="loader-loading"><img alt="" height="16" src="https://assets-cdn.github.com/assets/spinners/octocat-spinner-32-EAF2F5-0bdc57d34b85c4a4de9d0d1db10cd70e8a95f33ff4f46c5a8c48b4bf4e5a9abe.gif" width="16" /></p>
    <p class="loader-error">Cannot retrieve contributors at this time</p>
  </div>
</include-fragment>
<div class="file">
  <div class="file-header">
    <div class="file-actions">

      <div class="btn-group">
        <a href="/jhochenbaum/AnomalyDetection/raw/master/tests/testthat/test-ts.R" class="btn btn-sm " id="raw-url">Raw</a>
          <a href="/jhochenbaum/AnomalyDetection/blame/master/tests/testthat/test-ts.R" class="btn btn-sm js-update-url-with-hash">Blame</a>
        <a href="/jhochenbaum/AnomalyDetection/commits/master/tests/testthat/test-ts.R" class="btn btn-sm " rel="nofollow">History</a>
      </div>

        <a class="octicon-btn tooltipped tooltipped-nw"
           href="https://mac.github.com"
           aria-label="Open this file in GitHub for Mac">
            <span class="octicon octicon-device-desktop"></span>
        </a>

            <form accept-charset="UTF-8" action="/jhochenbaum/AnomalyDetection/edit/master/tests/testthat/test-ts.R" class="inline-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="9P9xZTBJSN/X8bdYMl47Q/BI2fELza7EB9VdLG5Mj033W54QuGm8OxpzxzzOOEbkGJlxeX/2PyLXAtBat7WRAQ==" /></div>
              <button class="octicon-btn tooltipped tooltipped-n" type="submit" aria-label="Clicking this button will fork this project so you can edit the file" data-hotkey="e" data-disable-with>
                <span class="octicon octicon-pencil"></span>
              </button>
</form>
          <form accept-charset="UTF-8" action="/jhochenbaum/AnomalyDetection/delete/master/tests/testthat/test-ts.R" class="inline-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="bZr8V95nVnfo8JIvznlT5AqvgzI2sOr2QH1EuWmeBiR7T+SFZNm4O5WAy6g1kNYImVj69P5thya+OQRiJWaS1Q==" /></div>
            <button class="octicon-btn octicon-btn-danger tooltipped tooltipped-n" type="submit" aria-label="Fork this project and delete file" data-disable-with>
              <span class="octicon octicon-trashcan"></span>
            </button>
</form>    </div>

    <div class="file-info">
        54 lines (42 sloc)
        <span class="file-info-divider"></span>
      2.18 kb
    </div>
  </div>
  
  <div class="blob-wrapper data type-r">
      <table class="highlight tab-size-8 js-file-line-container">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code js-file-line">library(<span class="pl-smi">AnomalyDetection</span>)</td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code js-file-line">context(<span class="pl-s"><span class="pl-pds">&quot;</span>Evaluation: AnomalyDetectionTs<span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>last day, both directions, with plot<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionTs(<span class="pl-smi">raw_data</span>, <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">only_last</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>day<span class="pl-pds">&#39;</span></span>, <span class="pl-v">plot</span><span class="pl-k">=</span><span class="pl-c1">T</span>)</td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">2</span>)</td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">25</span>)</td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code js-file-line">  expect_equal(class(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span><span class="pl-k">$</span><span class="pl-smi">timestamp</span>), c(<span class="pl-s"><span class="pl-pds">&quot;</span>POSIXlt<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>POSIXt<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code js-file-line">  expect_equal(class(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>), c(<span class="pl-s"><span class="pl-pds">&quot;</span>gg<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>ggplot<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>both directions, e_value, with longterm<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionTs(<span class="pl-smi">raw_data</span>, <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">longterm</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>, <span class="pl-v">e_value</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">3</span>)</td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">131</span>)</td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code js-file-line">  expect_equal(class(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span><span class="pl-k">$</span><span class="pl-smi">timestamp</span>), c(<span class="pl-s"><span class="pl-pds">&quot;</span>POSIXlt<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>POSIXt<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code js-file-line">  expect_equal(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>, <span class="pl-c1">NULL</span>)</td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>both directions, e_value, threshold set to med_max<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionTs(<span class="pl-smi">raw_data</span>, <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">threshold</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>med_max<span class="pl-pds">&quot;</span></span>, <span class="pl-v">e_value</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">3</span>)</td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">4</span>)</td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code js-file-line">  expect_equal(class(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span><span class="pl-k">$</span><span class="pl-smi">timestamp</span>), c(<span class="pl-s"><span class="pl-pds">&quot;</span>POSIXlt<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>POSIXt<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code js-file-line">  expect_equal(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>, <span class="pl-c1">NULL</span>)</td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code js-file-line">context(<span class="pl-s"><span class="pl-pds">&quot;</span>Evaluation: AnomalyDetectionVec<span class="pl-pds">&quot;</span></span>)</td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>last period, both directions, with plot<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionVec(<span class="pl-smi">raw_data</span>[[<span class="pl-c1">2</span>]], <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">period</span><span class="pl-k">=</span><span class="pl-c1">1440</span>, <span class="pl-v">only_last</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>, <span class="pl-v">plot</span><span class="pl-k">=</span><span class="pl-c1">T</span>)</td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">2</span>)</td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">25</span>)</td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code js-file-line">  expect_equal(class(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>), c(<span class="pl-s"><span class="pl-pds">&quot;</span>gg<span class="pl-pds">&quot;</span></span>, <span class="pl-s"><span class="pl-pds">&quot;</span>ggplot<span class="pl-pds">&quot;</span></span>))</td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>both directions, e_value, with longterm<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionVec(<span class="pl-smi">raw_data</span>[[<span class="pl-c1">2</span>]], <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">period</span><span class="pl-k">=</span><span class="pl-c1">1440</span>, <span class="pl-v">longterm_period</span><span class="pl-k">=</span><span class="pl-c1">1440</span><span class="pl-k">*</span><span class="pl-c1">14</span>, <span class="pl-v">e_value</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">3</span>)</td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">131</span>)</td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code js-file-line">  expect_equal(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>, <span class="pl-c1">NULL</span>)</td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code js-file-line">test_that(<span class="pl-s"><span class="pl-pds">&quot;</span>both directions, e_value, threshold set to med_max<span class="pl-pds">&quot;</span></span>, {</td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code js-file-line">  <span class="pl-smi">results</span> <span class="pl-k">&lt;-</span> AnomalyDetectionVec(<span class="pl-smi">raw_data</span>[[<span class="pl-c1">2</span>]], <span class="pl-v">max_anoms</span><span class="pl-k">=</span><span class="pl-c1">0.02</span>, <span class="pl-v">direction</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&#39;</span>both<span class="pl-pds">&#39;</span></span>, <span class="pl-v">period</span><span class="pl-k">=</span><span class="pl-c1">1440</span>, <span class="pl-v">threshold</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>med_max<span class="pl-pds">&quot;</span></span>, <span class="pl-v">e_value</span><span class="pl-k">=</span><span class="pl-c1">TRUE</span>)</td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>), <span class="pl-c1">3</span>)</td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code js-file-line">  expect_equal(length(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">anoms</span>[[<span class="pl-c1">2</span>]]), <span class="pl-c1">6</span>)</td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code js-file-line">  expect_equal(<span class="pl-smi">results</span><span class="pl-k">$</span><span class="pl-smi">plot</span>, <span class="pl-c1">NULL</span>)</td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code js-file-line">})</td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code js-file-line">
</td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code js-file-line">
</td>
      </tr>
</table>

  </div>

</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" action="" class="js-jump-to-line-form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="btn">Go</button>
</form></div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer" role="contentinfo">
    <ul class="site-footer-links right">
        <li><a href="https://status.github.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
      <li><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
      <li><a href="https://shop.github.com" data-ga-click="Footer, go to shop, text:shop">Shop</a></li>
        <li><a href="https://github.com/blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a href="https://github.com/about" data-ga-click="Footer, go to about, text:about">About</a></li>

    </ul>

    <a href="https://github.com" aria-label="Homepage">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
</a>
    <ul class="site-footer-links">
      <li>&copy; 2015 <span title="0.06786s from github-fe138-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="https://github.com/site/terms" data-ga-click="Footer, go to terms, text:terms">Terms</a></li>
        <li><a href="https://github.com/site/privacy" data-ga-click="Footer, go to privacy, text:privacy">Privacy</a></li>
        <li><a href="https://github.com/security" data-ga-click="Footer, go to security, text:security">Security</a></li>
        <li><a href="https://github.com/contact" data-ga-click="Footer, go to contact, text:contact">Contact</a></li>
    </ul>
  </div>
</div>


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-suggester-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder=""></textarea>
      <div class="suggester-container">
        <div class="suggester fullscreen-suggester js-suggester js-navigation-container"></div>
      </div>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    
    

    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x flash-close js-ajax-error-dismiss" aria-label="Dismiss error"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-695f9185473f9094970e0d7a6f7f527d07ae8560d44014f106186c28b3484b93.js"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-c3ad8c881e869082bb41b0f6b7be000bf156c60b7353798c398eeda5240e16f0.js"></script>
      
      

  </body>
</html>

