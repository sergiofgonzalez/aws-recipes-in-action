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


const credentials = new AWS.SharedIniFileCredentials({profile: config("AWS:PROFILE")});
AWS.config.credentials = credentials;

const ec2 = new AWS.EC2({region: config("AWS:REGION")});


ec2.describeImages({
  Filters: [{
    Name: "description",
    Values: ["Amazon Linux AMI*"]
  }]
}, (err, data) => {
  if (err) {
    logger.error(`Could not invoke describeImages: ${err}`);
    throw new Error(err);
  }

  // creating JavaScript objects with jmespath
  const resultObjects = jmespath.search(data, "Images[*].{imageid: ImageId, description: Description}");
  logger.info(`resultObjects=${util.inspect(resultObjects)}`);

  // retrieving as separate lists
  const amiIds = jmespath.search(data, "Images[*].ImageId");
  const descriptions = jmespath.search(data, "Images[*].Description");

  if (amiIds.length !== descriptions.length) {
    logger.error(`Unexpected state: sizes of amiIds and descriptions are different: ${amiIds.length} !== ${descriptions.length}`);
    throw new Error("Different sizes");
  }

  amiIds.forEach((item, index) => {
    logger.info(`${item} (${descriptions[index]})`);
  });
});