# Clarity Members URL Monitor

An internal tool to monitor Clarity users' Twitter streams for any links they post, search those linked pages for their own names, and capture any matching pages for internal review.

## Moving Parts

### User Stream

For a simple start we'll rely on a single Twitter account to maintain our list of Clarity users by following them. We'll monitor a user stream for our Twitter account that includes its followers.

### Filter Links

Tweets from the stream will be checked for links, and selected if they have one or more.

### Page Search

Link content will be fetched and a searched on the related user's name. Pages are selected if they have a match.

### Review

Matching pages will be viewable for review and related back to their Clarity user account.

## Concepts

* A queue of URLs with state that each relate to a User
* Allow the reviewer to audit and mark false positives/negatives for future improvements
* Fuzzy search on aliases, common nicknames, or short versions of names (e.g. Stephen, Steve)