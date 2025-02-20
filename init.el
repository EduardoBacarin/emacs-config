;;; Basic Configuration
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode 1)
(global-display-line-numbers-mode t)


;; Enable ORG Mode
;; (require 'org)
;; ORG Mode configs
;; (setq org-todo-keywords
;;	  '((sequence "TODO" "STARTED" "WAITING" "DONE")))

;;(setq org-todo-keyword-faces
;;      '(("TODO" . org-warning) ("STARTED" . "yellow")
;;        ("WAITING" . (:foreground "orange" :weight bold))
;;		("DONE" . "green") ))


;; packages
(require 'package)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(unless (package-installed-p 'php-mode)
  (package-refresh-contents)
  (package-install 'php-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)
;; Configurar web-mode para arquivos .blade.php
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.blade\\.php\\'" . web-mode))

;; Configurar web-mode para destacar PHP dentro de arquivos Blade
(defun my-web-mode-hook ()
  "Hook for Web mode."
  (setq web-mode-engines-alist '(("blade" . "\\.blade\\.php\\'")))
  (setq web-mode-content-types-alist '(("blade" . "\\.blade\\.php\\'")))
  (setq web-mode-enable-auto-pairing nil) ;; Opcional
  (setq web-mode-enable-css-colorization t) ;; Opcional
  ;;(setq web-mode-enable-block-face t) ;; Opcional
  (setq web-mode-enable-current-element-highlight t) ;; Opcional
  (setq web-mode-enable-current-column-highlight t) ;; Opcional
  (setq web-mode-enable-syntax-highlighting t) ;; Opcional
  (setq web-mode-enable-auto-quoting nil) ;; Opcional
  (setq web-mode-enable-auto-pairing nil) ;; Opcional
  (setq web-mode-enable-auto-indentation nil) ;; Opcional
  (setq web-mode-enable-auto-pairing nil)) ;; Opcional
(add-hook 'web-mode-hook 'my-web-mode-hook)

;; Emmet Mode
(use-package emmet-mode
  :hook ((html-mode css-mode) . emmet-mode))
(setenv "PATH" (concat "/usr/bin:" (getenv "PATH")))
(setq exec-path (cons "/usr/bin" exec-path))
;; Adiciona o caminho do Intelephense ao PATH do Emacs
(setenv "PATH" (concat "/home/bacarin/.nvm/versions/node/v23.3.0/bin:" (getenv "PATH")))
;; Atualiza a variável exec-path para o Emacs encontrar executáveis
(setq exec-path (cons "/home/bacarin/.nvm/versions/node/v23.3.0/bin" exec-path))

;; Instale php-mode
(use-package php-mode
  :ensure t
  :mode "\\.php\\'")
(setq php-mode-coding-style 'k&r) ;; Por exemplo, para usar o padrão PSR-2
;; Instale php-mode
(use-package go-mode
  :ensure t
  :mode "\\.go\\'")

;; Instale e configure lsp-mode
(use-package lsp-mode
  :ensure t
  :hook (php-mode . lsp) ;; Ativa lsp-mode para php-mode
  :commands lsp
  :config
  (setq lsp-enable-snippet nil) ;; Desativa snippets se você não usar
  (setq lsp-php-server-command "/home/bacarin/.nvm/versions/node/v23.3.0/bin/intelephense")) ;; Define o comando para o Intelephense
;; Instale e configure lsp-ui para suporte adicional
(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil))

;; js2-mode
(use-package js2-mode
  :mode "\\.js\\'")
;; Tide (TypeScript and JavaScript)
(use-package tide
  :after (typescript-mode js2-mode)
  :hook ((typescript-mode . tide-setup)
		 (js2-mode . tide-setup)))
;; Company Mode (completamento automático)
(use-package company
  :ensure t
  :hook (after-init . global-company-mode))

(use-package company-php
  :ensure t
  :config
  (add-to-list 'company-backends 'company-ac-php-backend))
;; Flycheck (linting e análise de código)
(use-package flycheck
  :hook (after-init . global-flycheck-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9724b3abaf500b227faa036dcf817abed9764802835ba6e8d1e475c877205157" "9fb561389e5ac5b9ead13a24fb4c2a3544910f67f12cfcfe77b75f36248017d0" "dbf0cd368e568e6139bb862c574c4ad4eec1859ce62bc755d2ef98f941062441" "dcb1cc804b9adca583e4e65755895ba0a66ef82d29464cf89a78b88ddac6ca53" "763bf89898a06b03f7b65fbc29857a1c292e4350246093702fdbd6c4e46e2cf0" default))
 '(ispell-dictionary nil)
 '(org-agenda-files
   '("/home/bacarin/org/agenda.org" "/home/bacarin/kontrl/kore/kanban.org"))
 '(package-selected-packages
   '(ac-php yasnippet go-mode exec-path-from-shell keychain-environment xref xref-rst neotree projectile cmake-mode swiper nordic-night-theme nord-theme atom-dark-theme timu-spacegrey-theme timu-macos-theme timu-macos-dark-theme treemacs move-text md-preview zenburn-theme tide artisan lsp-php web-mode phpunit phpactor php-mode magit lsp-ui json-mode js2-mode jquery-doc helm-ag flycheck emmet-mode dracula-theme counsel-projectile company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Verifica se o tema Monokai está instalado e o carrega
;; (unless (package-installed-p 'monokai-theme)
;; (package-refresh-contents)
;; (package-install 'monokai-theme))
;; Carrega o tema Monokai
(load-theme 'rebecca t)
;; Instale e configure o projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1) ;; Ativa o modo Projectile
  (setq projectile-project-search-path '("~/war/" )) ;; Ajuste os caminhos dos seus projetos
  (setq projectile-completion-system 'ivy) ;; Usa Ivy para completamento (se você usa Ivy)
  (setq projectile-enable-caching t) ;; Ativa o cache para melhorar a performance
  :bind
  (("C-c p f" . projectile-find-file) ;; Abre a lista de arquivos no projeto atual
   ("C-c p p" . projectile-switch-project) ;; Troca para um projeto diferente
   ("C-c p g" . projectile-grep) ;; Inicia uma busca no projeto atual
   ("C-c p s" . projectile-shell) ;; Abre um shell no diretório do projeto
   ("C-c p b" . projectile-switch-to-buffer) ;; Troca para um buffer do projeto
   ("C-c p d" . projectile-find-dir) ;; Abre a lista de diretórios do projeto
   ("C-c p a" . projectile-add-known-project) ;; Adiciona um novo projeto ao `projectile`
   ("C-c p r" . projectile-recentf) ;; Lista arquivos recentes do projeto
   ("C-c p k" . projectile-kill-buffers)
   ("C-c p i" . projectile-invalidate-cache)) ;; Mata todos os buffers do projeto
)
  (defun close-all-other-buffers ()
	"Fecha todos os buffers exceto o buffer atual."
	(interactive)
	(let ((current-buffer (current-buffer)))
	  (dolist (buffer (buffer-list))
		(unless (eq buffer current-buffer)
		  (kill-buffer buffer)))))
  (defun close-all-buffers ()
	"Fecha todos os buffers."
	(interactive)
	(mapc #'kill-buffer (buffer-list)))
  ;; Define a fonte e o tamanho da fonte globalmente
  (set-face-attribute 'default nil :family "JetBrains Mono" :height 130)
  ;; Instalar e configurar Magit usando use-package
  (use-package magit
	:ensure t
	:bind (("C-x g" . magit-status)) ;; Define o atalho para Magit Status
	:config)
  ;; Defina o diretório para backups
  (setq backup-directory-alist '(("." . "~/.emacs_backups")))
  ;; Certifique-se de que os backups sejam criados
  (setq make-backup-files t)
  ;; MARKDOWN
  (use-package markdown-mode
	:ensure t
	:mode ("README\\.md\\'" . gfm-mode)
	:init (setq markdown-command "multimarkdown"))
  ;; Comando e atalho para duplicar a linha atual
  (defun duplicate-current-line ()
	"Duplica a linha atual."
	(interactive)
	(let ((current-line (thing-at-point 'line t)))
	  (save-excursion
		(end-of-line)
		(newline)
		(insert current-line))))
  (global-set-key (kbd "C-c d") 'duplicate-current-line)
  ;; Ativa os observadores de arquivos
  (setq lsp-enable-file-watchers t)
  ;; para mover a linha, usar ALT setas
  (use-package move-text
	:ensure t
	:bind (("M-<S-up>" . move-text-up)
		   ("M-<S-down>" . move-text-down)))
  (use-package neotree
	:ensure t
	:bind
	(("C-x t" . neotree-toggle)))
  (unless (package-installed-p 'swiper)
	(package-refresh-contents)
	(package-install 'swiper))
  (ivy-mode 1) ;; Ativa o Ivy para uma melhor interface de seleção
  (global-set-key "\C-s" 'swiper) ;; Mapeia Ctrl+s para o Swiper
  (global-set-key "\C-r" 'swiper) ;; Mapeia Ctrl+r para o Swiper reverso
  ;; Configurações adicionais
  ;;(setq-default indent-tabs-mode nil) ;; Usar espaços em vez de tabs
  (setq-default tab-width 4) ;; Largura de tabulação padrão
  ;; Função para configurar identação
  (defun my-setup-indentation ()
	"Configura a identação com 4 espaços."
	;;(setq indent-tabs-mode nil)
	(setq tab-width 4)
	(setq-default tab-width 4)
	(setq php-mode-coding-style 'k&r) ;; Configura estilo de codificação PHP
	(setq-default php-indent 4)) ;; Ajusta identação para PHP
  (defun my-cleanup-and-indent ()
	(interactive)
	(my-setup-indentation) ;; Aplica as configurações de indentação
	(delete-trailing-whitespace) ;; Remove espaços em branco no final das linhas
	;; Remove múltiplos espaços entre palavras, ignorando os espaços no início da linha
	(goto-char (point-min))
	(while (re-search-forward "\\([^[:space:]]\\)[[:space:]]\\{2,\\}" nil t)
	  (replace-match "\\1 "))
	;; Remove espaços em branco antes de quebras de linha
	(goto-char (point-min))
	(while (re-search-forward "\\s-+\n" nil t)
	  (replace-match "\n"))
	;; Reduz múltiplas linhas em branco consecutivas para apenas uma
	(goto-char (point-min))
	(while (re-search-forward "\n\\{2,\\}" nil t)
	  (replace-match "\n\n"))
	;; Indentar todo o buffer
	(indent-region (point-min) (point-max)))
  ;; Atalho para a função
  (global-set-key [f2] 'my-cleanup-and-indent)

  ;; Configura indentação para modos de programação
  (add-hook 'prog-mode-hook 'my-setup-indentation) ;; Para todos os modos de programação
  (add-hook 'python-mode-hook 'my-setup-indentation) ;; Para Python
  (add-hook 'java-mode-hook 'my-setup-indentation) ;; Para Java
  (add-hook 'c-mode-hook 'my-setup-indentation) ;; Para C
  (add-hook 'php-mode-hook 'my-setup-indentation) ;; Para PHP
  (add-hook 'makefile-mode-hook 'my-setup-indentation) ;; Para Makefile

  (setq lsp-enable-file-watchers t)
  (setq lsp-file-watch-threshold 5000)

  ;; ssh
  (require 'exec-path-from-shell)
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")

  (windmove-default-keybindings 'meta)

  (desktop-save-mode 1)

;; golang config
(require 'go-mode)
(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook 'subword-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook (lambda ()
                          ;;(setq tab-width 4)
                          (flycheck-add-next-checker 'lsp 'go-vet)
                          (flycheck-add-next-checker 'lsp 'go-staticcheck)))
;; org mode
(load-file "~/.emacs.d/org.el")
