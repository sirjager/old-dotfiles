local ok, pkg = pcall(require, "cmp-graphql")
if not ok then
  return
end

pkg.setup {
  schema_path = "graphql.schema.json",
}

-- Add graphql source to your cmp config
-- cmp.setup({
--   -- ...
--   sources = {
--     -- ...
--     { name = 'graphql' }
--   }
-- })
-- Generate schema json file (Using @graphql-codegen/cli)
-- Install @graphql-codegen/cli
-- yarn add -D @graphql-codegen/cli
-- Run codegen init to setup the codegen config file
-- NOTE: Make sure introspection json is enabled. The only relevant generated file is the schema json file.
--
-- yarn graphql-codegen init
-- And then to generate the schema json file
-- yarn && yarn codegen
-- Setup cmp-graphql for your project with
-- require('cmp-graphql').setup({
--   schema_path = 'graphql.schema.json', -- Path to generated json schema file in project
-- })
