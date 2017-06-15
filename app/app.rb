#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'aws-sdk'

PAGE_URL = "https://www.zendesk.com/jobs/madison/"
CUR_COUNT = 2

def spam_my_phone(num)
    sns = Aws::SNS::Client.new({
        region: 'us-east-1'
    })

    response = sns.publish({
        topic_arn: 'arn:aws:sns:us-east-1:076479453187:NotifyMe',
        message: "Elizabeth! This is the big one! Submit your resume to ZD, Dummy! There are #{num}"
    })

    puts response.message_id
end

doc = Nokogiri::HTML(open(PAGE_URL))

jobs = doc.css('.engineeringproduct').xpath("..").css('li > h4')

if jobs.count != CUR_COUNT
    spam_my_phone(jobs.count)
end
