local home = os.getenv("HOME")
-- local jdtls_path = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls")
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/jdtls'
local launcher = vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", "1")
-- local launcher = vim.fn.glob(home .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar", "1")
-- local launcher = vim.fn.glob("$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher.jar", "1")
local root_dir = require("jdtls.setup").find_root({ ".git", "build.gradle", "pom.xml" }) or vim.fn.getcwd()
local workspace_path = home .. "/.cache/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local keymaps = require('config.keymaps')
-- Ensure workspace directory exists
os.execute("mkdir -p " .. workspace_path)

vim.env.JAVA_HOME = vim.env.JAVA_HOME or "/usr/lib/jvm/java-21-openjdk"

-- vim.lsp.log.set_level("debug")

local function ensure_java_debug_and_test()
    local debug_path = vim.fn.stdpath('data') .. '/mason/packages/java-debug'
    local test_path = vim.fn.stdpath('data') .. '/mason/packages/vscode-java-test'

    -- Clone java-debug if not exists
    if vim.fn.empty(vim.fn.glob(debug_path)) > 0 then
        vim.fn.system({ 'git', 'clone', 'https://github.com/microsoft/java-debug.git', debug_path })
        vim.fn.system({ '/bin/sh', '-c', 'cd ' .. debug_path .. ' && ./mvnw clean install' })
    end

    -- Clone vscode-java-test if not exists
    if vim.fn.empty(vim.fn.glob(test_path)) > 0 then
        vim.fn.system({ 'git', 'clone', 'https://github.com/microsoft/vscode-java-test.git', test_path })
        vim.fn.system({ '/bin/sh', '-c', 'cd ' ..
        test_path .. ' && npm install --legacy-peer-deps && npx gulp vsCodeJavaTestServer' })
    end
end


local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "-Xmx2G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "--add-opens", "jdk.incubator.vector/jdk.incubator.vector=ALL-UNNAMED",   -- For Java 21
        "--add-opens", "jdk.incubator.foreign/jdk.incubator.foreign=ALL-UNNAMED", -- For Java 21
        -- '-javaagent:' .. home .. '/.local/bin/lombok.jar',
        -- "-jar", jdtls_path .. "/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
        "-jar", launcher,
        "-configuration", jdtls_path .. "/config_linux",
        "-data", workspace_path,
        -- "-Dlog.file.path=" .. home .. "/jdtls.log",  -- Add this line
    },
    root_dir = root_dir,
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    settings = {
        java = {
            signatureHelp = { enabled = true },
        },
        contentProvider = { preferred = "fernflower" },
        completion = {
            favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
            },
        },
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
        },
    },
    init_options = {
        settings = {
            java = {
                implementationsCodeLens = { enabled = true },
                imports = { -- <- this
                    gradle = {
                        enabled = true,
                        wrapper = {
                            enabled = true,
                            checksums = {
                                {
                                    sha256 = '7e3076c1709741964baa432ffd88e8f24627d05daf6d86ed360b09e49ea0ca9b',
                                    allowed = true
                                }
                            },
                        }
                    }
                }
            }
        },
        bundles = {
            vim.fn.glob(
                vim.fn.stdpath('data') ..
                '/mason/packages/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
                true),
        },
    },
    on_attach = function(client, bufnr)
        keymaps.setup_lsp_keymaps(bufnr)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require('jdtls.dap').setup_dap_main_class_configs()
        -- require('jdtls').setup.add_commands()
    end,
}
vim.b.disable_mason_lsp = true
-- Call the function when setting up jdtls
ensure_java_debug_and_test()
require("jdtls").start_or_attach(config)
