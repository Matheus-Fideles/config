-- DevOps: Terraform, Helm, YAML, Kubernetes configuration
return {
  -- Mason tools for DevOps
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Terraform
        "terraform-ls",
        "tflint",
        -- YAML/Kubernetes
        "yaml-language-server",
        "yamllint",
        "yamlfmt",
        -- Helm
        "helm-ls",
        -- Docker
        "dockerfile-language-server",
        "docker-compose-language-service",
        "hadolint", -- Dockerfile linter
        -- JSON
        "jsonlint",
        -- Bash/Shell
        "bash-language-server",
        "shellcheck",
        "shfmt",
      })
    end,
  },

  -- LSP configurations
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Terraform
        terraformls = {
          filetypes = { "terraform", "terraform-vars", "tf" },
        },
        -- YAML with Kubernetes schema support
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = {
                -- Kubernetes schemas
                ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.28.0-standalone/all.json"] = {
                  "k8s/**/*.yaml",
                  "k8s/**/*.yml",
                  "kubernetes/**/*.yaml",
                  "kubernetes/**/*.yml",
                  "*-deployment.yaml",
                  "*-service.yaml",
                  "*-configmap.yaml",
                  "*-secret.yaml",
                  "*-ingress.yaml",
                  "deployment*.yaml",
                  "service*.yaml",
                },
                -- Docker Compose
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
                  "docker-compose*.yaml",
                  "docker-compose*.yml",
                  "compose*.yaml",
                  "compose*.yml",
                },
                -- GitHub Actions
                ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
                ["https://json.schemastore.org/github-action.json"] = ".github/actions/*/action.{yml,yaml}",
                -- Helm Chart.yaml
                ["https://json.schemastore.org/chart.json"] = "Chart.yaml",
                -- Helm values
                kubernetes = "values*.yaml",
              },
            },
          },
        },
        -- Helm
        helm_ls = {
          filetypes = { "helm" },
          cmd = { "helm_ls", "serve" },
        },
        -- Docker
        dockerls = {},
        docker_compose_language_service = {
          filetypes = { "yaml.docker-compose" },
        },
        -- Bash
        bashls = {
          filetypes = { "sh", "bash", "zsh" },
        },
      },
    },
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "terraform",
        "hcl",
        "yaml",
        "json",
        "dockerfile",
        "bash",
        "toml",
        "ini",
      })
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        yaml = { "yamlfmt" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
      },
    },
  },

  -- Linting
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        terraform = { "tflint" },
        tf = { "tflint" },
        yaml = { "yamllint" },
        dockerfile = { "hadolint" },
      },
    },
  },

  -- Helm filetype detection
  {
    "towolf/vim-helm",
    ft = "helm",
  },

  -- Kubernetes integration
  {
    "ramilito/kubectl.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>K", "", desc = "+Kubectl" },
      {
        "<leader>Kk",
        function()
          require("kubectl").toggle()
        end,
        desc = "Toggle Kubectl",
      },
    },
    opts = {},
  },

  -- Terraform documentation
  {
    "ANGkeith/telescope-terraform-doc.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension("terraform_doc")
    end,
    keys = {
      { "<leader>tfd", "<cmd>Telescope terraform_doc<cr>", desc = "Terraform Docs" },
      { "<leader>tfm", "<cmd>Telescope terraform_doc modules<cr>", desc = "Terraform Modules" },
      {
        "<leader>tfa",
        "<cmd>Telescope terraform_doc full_name=hashicorp/aws<cr>",
        desc = "Terraform AWS Provider",
      },
    },
  },

  -- File type associations
  {
    "nvim-lua/plenary.nvim",
    init = function()
      vim.filetype.add({
        extension = {
          tf = "terraform",
          tfvars = "terraform",
          hcl = "hcl",
        },
        filename = {
          ["docker-compose.yaml"] = "yaml.docker-compose",
          ["docker-compose.yml"] = "yaml.docker-compose",
          ["compose.yaml"] = "yaml.docker-compose",
          ["compose.yml"] = "yaml.docker-compose",
        },
        pattern = {
          [".*%.yaml%.tpl"] = "helm",
          [".*%.yml%.tpl"] = "helm",
          ["templates/.*%.yaml"] = "helm",
          ["templates/.*%.yml"] = "helm",
          ["templates/.*%.tpl"] = "helm",
          [".*/templates/.*%.yaml"] = "helm",
          [".*/templates/.*%.yml"] = "helm",
        },
      })
    end,
  },

  -- Which-key groups
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>K", group = "Kubectl", icon = "󱃾" },
        { "<leader>tf", group = "Terraform", icon = "󱁢" },
      },
    },
  },
}
