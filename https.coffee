{ request } = (require "node:https")

createClient = (host) =>
    get: (path) =>
        new Promise((resolve, reject) =>
            options =
                hostname: host
                port: 443
                path: path
                method: 'GET'
                "Content-Type": "application/json"
            req = request options, (res) =>
                data = ""
                res.on "data", (chunk) => data += chunk
                res.on "end", => resolve (JSON.parse data)[0]
            req.on "error", reject
            req.end()
        )

module.exports = { createClient }
