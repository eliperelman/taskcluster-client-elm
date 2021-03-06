# Neo

Scaffold out a React-based front-end application with initial zero configuration

## Features

- React, Redux, React Router
- Webpack
- ESLint, Babel, ES2015 + modules, Stage 0 preset
- Tests and coverage with Karma, Mocha, Chai, Enzyme, and Chrome
- Node.js v6
- Bootstrap 4 and Sass
- Travis CI
- Immutable

## Installation

#### Global

```bash
npm install -g mozilla-neo
mkdir <project-name> && cd <project-name>
neo init # and follow the prompts
```

#### Local

```bash
mkdir -p <project-name>/node_modules && cd <project-name>
npm install mozilla-neo
node_modules/.bin/neo init # and follow the prompts
```

##### Sample output

```bash
→ create package.json
→ create src/
→ create tests/
→ create .gitignore
→ create .travis.yml
→ create LICENSE
→ create README.md
```

#### Workflow

- Add code to `src/` and tests to `tests/`.
- Build and watch changes in `src/` with `npm start`.
- Lint and build the project with `npm run build`.
- Run tests with `npm test`.

## Contribute

- Issue Tracker: [https://github.com/mozilla/neo/issues](https://github.com/mozilla/neo/issues)
- Source Code: [https://github.com/mozilla/neo](https://github.com/mozilla/neo)
- Code of Conduct: [Adapted from Rust CoC](https://www.rust-lang.org/conduct.html)

## Support

If you are having issues, please let us know.
We have an IRC channel `#tc-frontend` on [Mozilla IRC](https://wiki.mozilla.org/IRC)


## License

This project is licensed under the [Mozilla Public License v2.0](https://github.com/mozilla/neo/blob/master/LICENSE)
