const express = require('express')
const util = require('util');
const app = express()
const exec = util.promisify(require('child_process').exec);
const system_command = process.env.SYSTEM_COMMAND;

async function run_system_command(cmd) {
    const { stdout, stderr } = await exec(cmd);
    console.log('stdout:', stdout.replace(/[\n\r]+/g, ''));
    if(stderr) {
        console.log('stderr:', stderr);
    }
}

app.use(express.json())
app.post(
    '/data',
    (req, res) => {
        console.log(JSON.stringify(req.body))
        if (system_command) {
            run_system_command(system_command)
        } 
        return res.json(req.body)
    }
)

const PORT = process.env.PORT || 4000
app.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`)
})