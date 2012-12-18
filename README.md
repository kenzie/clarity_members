# Clarity Members URL Monitor

An internal tool to monitor subscribed users' Twitter streams for any links they post, search those linked pages for real user names, and capture any matching pages for internal review.

## Moving Parts

### Follow

For a simple start we'll rely on a single Twitter account to maintain our list of users by following them.

### Stream

We'll monitor a user stream for our Twitter account that includes its followers, listening for any tweet with a URL and queueing those new URLs for processing.

### Search

The URL processor will take new links from the queue and fetch the page, then search the content for the related user's name. The page is marked in the queue as either a match or not a match.

### Review

Pages marked as matching will be viewable for review and related back to their application user account.

## Concepts

* User (id, name, aliases, twitter screen name), URL (new, unmatched, matched)
* A queue of URLs with state that relate to a User
* Learn from mistakes – allow the reviewer to mark false positives, audit for false negatives
* Fuzzy search on aliases, common nicknames, or short versions of names (e.g. Stephen, Steve)