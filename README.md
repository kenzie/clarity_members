# Clarity Members URL Monitor

An internal tool to monitor Clarity users' Twitter streams for any links they post, search those linked pages for their own names, and capture any matching pages for internal review.

## Moving Parts

### User Stream

For a simple start we'll rely on a single Twitter account to maintain our list of Clarity users by following them. We'll monitor a user stream for our Twitter account that includes its followers.

### Filter Links

Tweets from the stream will be checked for links, and selected if they have one or more.

### Page Search

Link content will be fetched and searched for the related user's name/aliases. Pages are selected for review if they have a match.

### Review

Matching pages will be viewable for review and related back to their Clarity user account.

## Concepts

* A queue of URLs with state that each relate to a User
* Allow the reviewer to audit and mark false positives/negatives for future improvements
* Fuzzy search on aliases: common nicknames, or short versions of names (e.g. Stephen, Steve)

## TODO

* Choose persistence for Links and Users (i.e. Redis, MongoDB, Postgres)

## ERROR LOG

  Encoding::CompatibilityError (incompatible encoding regexp match (UTF-8 regexp with ASCII-8BIT string)):
  16:40:28 links.1  |   /Users/kenzie/Sites/clarity_members/lib/page.rb:17:in `search'
  16:40:28 links.1  |   /Users/kenzie/Sites/clarity_members/lib/link.rb:40:in `perform'

  SEARCHING PAGE... http://bit.ly/UfvlNz
  HTTParty::RedirectionTooDeep (HTTP redirects too deep):
