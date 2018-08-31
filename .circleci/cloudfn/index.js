/**
 * Responds to any HTTP request.
 *
 * @param {!express:Request} req HTTP request context.
 * @param {!express:Response} res HTTP response context.
 */
let exec = require('child_process').execSync;
const cmd = 'PATH=$PATH:/nodejs/bin gren changelog --generate -m --override -B --tags=all -L duplicate,invalid,need_infos,question,stale,wontfix -I duplicate,invalid,need_infos,question,stale,wontfix -D milestones -p v -g label';



exports.helloWorld = (req, res) => {
  let action = req.body.action;
  let title = req.body.milestone.title;
  let milestoneID = req.body.milestone.number;

  if (action == 'closed') {
    console.log(`Milestone ${title} closed`);

    console.log(exec(cmd, function(error, stdout, stderr) {
      // command output is in stdout
      console.log(error);
      console.log(stdout);
      console.log(stderr);
    }).toString('utf8'));

    console.log(exec('cat CHANGELOG.md', function(error, stdout, stderr) {
      // command output is in stdout
      console.log(error);
      console.log(stdout);
      console.log(stderr);
    }).toString('utf8'));

    // exec(cmd, function(error, stdout, stderr) {
    //   // command output is in stdout
    //   console.log(error);
    //   console.log(stdout);
    //   console.log(stderr);
    // });
  }
  res.status(200).send('ok');
};
