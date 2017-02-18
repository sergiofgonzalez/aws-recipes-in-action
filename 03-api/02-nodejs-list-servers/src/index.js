"use strict";

const util = require("util");

const log4js = require("log4js");
const AWS = require("aws-sdk");
const jmespath = require("jmespath");

const config = require("./lib/config");

// Logger configuration
const logger = log4js.getLogger("index.js");
logger.setLevel(config("LOGGER:LEVEL"));

util.inspect.defaultOptions.depth = null;


// logger.info(`AWS_PROFILE=${config("AWS_PROFILE")}`);
// logger.info(`AWS_PROFILE=${process.env["AWS_PROFILE"]}`);

const credentials = new AWS.SharedIniFileCredentials({profile: config("AWS:PROFILE")});
AWS.config.credentials = credentials;

const ec2 = new AWS.EC2({region: config("AWS:REGION")});

/* Describe Instances in pending, running, stopped having a tag with key = Name */
ec2.describeInstances({
  Filters: [{
    Name: "instance-state-name",
    Values: ["pending" ,"running", "stopped"],    
  }, {
    Name:"tag-key",
    Values:["Name"]
  }]
}, (err, data) => {
  if (err) {
    logger.error(`Could not invoke describeInstances: ${err}`);
    throw new Error(err);
  }


  const servers = jmespath.search(data, "Reservations[].Instances[].{instanceId: InstanceId, name: Tags[0].Value}");
  logger.debug(`data=${util.inspect(data)}`);


  logger.info(`resultObjects=${util.inspect(servers)}`);
});


ec2.describeInstances({
  Filters: [{
    Name: "instance-state-name",
    Values: ["pending" ,"running", "stopped"],    
  }],
  MaxResults: 10
}, (err, data) => {
  if (err) {
    logger.error(`Could not invoke describeInstances: ${err}`);
    throw new Error(err);
  }


  const servers = jmespath.search(data, "Reservations[].Instances[].{instanceId: InstanceId, tags: Tags[]}");

  logger.info(`resultObjects=${util.inspect(servers)}`);
});