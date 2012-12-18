require_relative '../../lib/filter'

describe Filter do
  raw_tweet_with_no_link = %q{{"created_at":"Mon Dec 17 13:19:29 +0000 2012","id":280663508364951552,"id_str":"280663508364951552","text":"Test tweet","source":"\u003ca href=\"http:\/\/www.apple.com\/\" rel=\"nofollow\"\u003eOS X\u003c\/a\u003e","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":2884181,"id_str":"2884181","name":"Kenzie Campbell","screen_name":"kenziecampbell","location":"Cape Breton, Nova Scotia","description":"Web developer. Dandelion enthusiast.","url":"http:\/\/route19.com","entities":{"url":{"urls":[{"url":"http:\/\/route19.com","expanded_url":null,"indices":[0,18]}]},"description":{"urls":[]}},"protected":false,"followers_count":106,"friends_count":76,"listed_count":10,"created_at":"Thu Mar 29 19:46:09 +0000 2007","favourites_count":507,"utc_offset":-14400,"time_zone":"Atlantic Time (Canada)","geo_enabled":true,"verified":false,"statuses_count":1645,"lang":"en","contributors_enabled":false,"is_translator":false,"profile_background_color":"494040","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme18\/bg.gif","profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme18\/bg.gif","profile_background_tile":false,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/2638378421\/a4110e8ca43fd6edcaf2a58db4cff871_normal.jpeg","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/2638378421\/a4110e8ca43fd6edcaf2a58db4cff871_normal.jpeg","profile_link_color":"9A5515","profile_sidebar_border_color":"EEEEEE","profile_sidebar_fill_color":"F6F6F6","profile_text_color":"333333","profile_use_background_image":false,"default_profile":false,"default_profile_image":false,"following":true,"follow_request_sent":false,"notifications":null},"geo":null,"coordinates":null,"place":null,"contributors":null,"retweet_count":0,"entities":{"hashtags":[],"urls":[],"user_mentions":[]},"favorited":false,"retweeted":false,"possibly_sensitive":false}}
  raw_tweet_with_one_link = %q{{"created_at":"Mon Dec 17 13:19:29 +0000 2012","id":280663508364951552,"id_str":"280663508364951552","text":"Test tweet: http:\/\/t.co\/a3MiRdL2","source":"\u003ca href=\"http:\/\/www.apple.com\/\" rel=\"nofollow\"\u003eOS X\u003c\/a\u003e","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":2884181,"id_str":"2884181","name":"Kenzie Campbell","screen_name":"kenziecampbell","location":"Cape Breton, Nova Scotia","description":"Web developer. Dandelion enthusiast.","url":"http:\/\/route19.com","entities":{"url":{"urls":[{"url":"http:\/\/route19.com","expanded_url":null,"indices":[0,18]}]},"description":{"urls":[]}},"protected":false,"followers_count":106,"friends_count":76,"listed_count":10,"created_at":"Thu Mar 29 19:46:09 +0000 2007","favourites_count":507,"utc_offset":-14400,"time_zone":"Atlantic Time (Canada)","geo_enabled":true,"verified":false,"statuses_count":1645,"lang":"en","contributors_enabled":false,"is_translator":false,"profile_background_color":"494040","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme18\/bg.gif","profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme18\/bg.gif","profile_background_tile":false,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/2638378421\/a4110e8ca43fd6edcaf2a58db4cff871_normal.jpeg","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/2638378421\/a4110e8ca43fd6edcaf2a58db4cff871_normal.jpeg","profile_link_color":"9A5515","profile_sidebar_border_color":"EEEEEE","profile_sidebar_fill_color":"F6F6F6","profile_text_color":"333333","profile_use_background_image":false,"default_profile":false,"default_profile_image":false,"following":true,"follow_request_sent":false,"notifications":null},"geo":null,"coordinates":null,"place":null,"contributors":null,"retweet_count":0,"entities":{"hashtags":[],"urls":[{"url":"http:\/\/t.co\/a3MiRdL2","expanded_url":"http:\/\/gapingvoid.com\/2012\/12\/13\/artisnal\/#comment-93508","display_url":"gapingvoid.com\/2012\/12\/13\/art\u2026","indices":[20,40]}],"user_mentions":[]},"favorited":false,"retweeted":false,"possibly_sensitive":false}}
  raw_tweet_with_multiple_links = %q{{"created_at":"Tue Dec 18 20:44:17 +0000 2012","id":281137831995392000,"id_str":"281137831995392000","text":"Two contrasting views on the same problem from @brynary and @dhh: http:\/\/t.co\/5biosb8u vs http:\/\/t.co\/748VQjAA","source":"\u003ca href=\"http:\/\/itunes.apple.com\/us\/app\/twitter\/id409789998?mt=12\" rel=\"nofollow\"\u003eTwitter for Mac\u003c\/a\u003e","truncated":false,"in_reply_to_status_id":null,"in_reply_to_status_id_str":null,"in_reply_to_user_id":null,"in_reply_to_user_id_str":null,"in_reply_to_screen_name":null,"user":{"id":15994184,"id_str":"15994184","name":"mattwynne","screen_name":"mattwynne","location":"Scottish Highlands","description":"I like tea, I like solving problems and I like making things. I'm curious about how we can make software development more enjoyable for everyone involved.","url":"http:\/\/mattwynne.net","entities":{"url":{"urls":[{"url":"http:\/\/mattwynne.net","expanded_url":null,"indices":[0,20]}]},"description":{"urls":[]}},"protected":false,"followers_count":1954,"friends_count":411,"listed_count":147,"created_at":"Tue Aug 26 09:05:50 +0000 2008","favourites_count":39,"utc_offset":0,"time_zone":"London","geo_enabled":true,"verified":false,"statuses_count":3923,"lang":"en","contributors_enabled":false,"is_translator":false,"profile_background_color":"C0DEED","profile_background_image_url":"http:\/\/a0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_image_url_https":"https:\/\/si0.twimg.com\/images\/themes\/theme1\/bg.png","profile_background_tile":false,"profile_image_url":"http:\/\/a0.twimg.com\/profile_images\/59047117\/Matt_Black_and_White_normal.jpg","profile_image_url_https":"https:\/\/si0.twimg.com\/profile_images\/59047117\/Matt_Black_and_White_normal.jpg","profile_link_color":"0084B4","profile_sidebar_border_color":"C0DEED","profile_sidebar_fill_color":"DDEEF6","profile_text_color":"333333","profile_use_background_image":true,"default_profile":true,"default_profile_image":false,"following":false,"follow_request_sent":false,"notifications":false},"geo":null,"coordinates":null,"place":null,"contributors":null,"retweet_count":8,"entities":{"hashtags":[],"urls":[{"url":"http:\/\/t.co\/5biosb8u","expanded_url":"http:\/\/blog.codeclimate.com\/blog\/2012\/10\/17\/7-ways-to-decompose-fat-activerecord-models\/","display_url":"blog.codeclimate.com\/blog\/2012\/10\/1\u2026","indices":[66,86]},{"url":"http:\/\/t.co\/748VQjAA","expanded_url":"http:\/\/37signals.com\/svn\/posts\/3372","display_url":"37signals.com\/svn\/posts\/3372","indices":[90,110]}],"user_mentions":[{"screen_name":"brynary","name":"Bryan Helmkamp","id":2049071,"id_str":"2049071","indices":[47,55]},{"screen_name":"dhh","name":"DHH","id":14561327,"id_str":"14561327","indices":[60,64]}]},"favorited":false,"retweeted":false,"possibly_sensitive":false}}
  describe "#get_links" do
    context "given a tweet with a link" do
      response = Filter.new(raw_tweet_with_one_link)
      it "returns screen name and link" do
        expect(response.get_links).to eq ['kenziecampbell', ['http://gapingvoid.com/2012/12/13/artisnal/#comment-93508']]
      end
    end
    context "given a tweet with multiple links" do
      response = Filter.new(raw_tweet_with_multiple_links)
      it "returns screen name and all links" do
        expect(response.get_links).to eq ["mattwynne", ["http://blog.codeclimate.com/blog/2012/10/17/7-ways-to-decompose-fat-activerecord-models/", "http://37signals.com/svn/posts/3372"]]
      end
    end
    context "given a tweet without a link" do
      response = Filter.new(raw_tweet_with_no_link)
      it "returns false" do
        expect(response.get_links).to be_false
      end
    end
  end
end