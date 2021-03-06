const path = require('path');
const Vorpal = require('vorpal');
const yeoman = require('yeoman-environment');
const { commands } = require('./package.json');

let cli = new Vorpal();
let env = yeoman.createEnv();
let register = (command) => {
  let {
    name,
    generator,
    options = []
  } = command;
  let dir = path.resolve(__dirname, `commands/${name}`);

  if (generator) {
    env.register(require.resolve(dir), `tc-elm:${name}`);
  }

  let cliCommand = cli.command(name, command.description);

  Object
    .keys(options)
    .map(option => {
      if (Array.isArray(options[option])) {
        cliCommand.option(option, ...options[option]);
      } else {
        cliCommand.option(option, options[option]);
      }
    });

  cliCommand
    .action(function(args) {
      let done = () => process.exit(0);

      if (this.commandObject._events) {
        let options = Object
          .keys(this.commandObject._events)
          .reduce((base, key) => {
            base[key] = this.commandObject[key];
            return base;
          }, {});

        args.options = Object.assign(options, args.options);
      }

      process.env.NODE_ENV = command.environment || 'development';

      if (generator) {
        env.run(`tc-elm:${name}`, done);
      } else {
        require(dir)(args, done);
      }
    });
};

commands.map(register);

cli
  .find('exit')
  .hidden();

cli.parse(process.argv[2] ? process.argv : [...process.argv, 'help']);
