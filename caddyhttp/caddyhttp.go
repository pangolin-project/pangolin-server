// Copyright 2015 Light Code Labs, LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package caddyhttp

import (
	// plug in the server
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/httpserver"

	// plug in the standard directives
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/basicauth"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/bind"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/browse"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/errors"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/expvar"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/extensions"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/fastcgi"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/gzip"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/header"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/index"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/internalsrv"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/limits"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/log"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/markdown"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/mime"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/pprof"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/proxy"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/push"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/redirect"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/requestid"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/rewrite"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/root"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/status"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/templates"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/timeouts"
	_ "github.com/pangolin-project/pangolin-server/caddyhttp/websocket"
	_ "github.com/pangolin-project/pangolin-server/onevent"
)
