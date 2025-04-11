# 🏠 Aplicativo de Gerenciamento de Usuários e Endereços

Este é um projeto Flutter simples que permite o cadastro de usuários, autenticação e gerenciamento de endereços. Ele simula um pequeno sistema CRUD local, utilizando boas práticas de organização em camadas como **Controllers**, **Services**, **Models**, **Utils** e **Views**.

---

## Print 1: Crud de Endereços
![alt text](<doc/img/Captura de tela 2025-04-11 081829.png>)

## Print 2: Lista de Usuários
![alt text](<doc/img/Captura de tela 2025-04-11 081842.png>)

## Print 3: Tela de Cadastro de Endereços
![alt text](<doc/img/Captura de tela 2025-04-11 083041.png>)

---
## 📁 Estrutura de Pastas

```
lib/
├── controllers/
│   ├── endereco_controller.dart
│   └── usuario_controller.dart
├── models/
│   ├── endereco_model.dart
│   └── usuario_model.dart
├── services/
│   ├── endereco_service.dart
│   └── usuario_service.dart
├── utils/
│   ├── hash_util.dart
│   └── session_manager.dart
├── views/
│   ├── cadastro_endereco_view.dart
│   ├── cadastro_usuario_view.dart
│   ├── editar_endereco_view.dart
│   ├── enderecos_view.dart
│   ├── list_usuarios_view.dart
│   └── welcome_view.dart
└── main.dart
```

---

## 🚀 Funcionalidades

- ✅ Cadastro de usuários com senha criptografada (`hash_util`)
- ✅ Autenticação de login com validação segura
- ✅ Gerenciamento de sessão simulada (`session_manager`)
- ✅ CRUD de endereços
- ✅ Separação de responsabilidades (MVC + Service Layer)
- ✅ Navegação entre telas com validação

---

## 📲 Telas principais

- `WelcomeView`: Tela inicial com login e acesso ao cadastro
- `CadastroUsuarioView`: Tela de criação de usuário
- `EnderecosView`: Página principal após login com acesso à lista de endereços
- `CadastroEnderecoView`, `EditarEnderecoView`: Telas para adicionar e editar endereços
- `ListUsuariosView`: Exibe todos os usuários cadastrados

---

## 🧠 Tecnologias Utilizadas

- **Flutter** (SDK >= 3.10.0)
- `Dart` como linguagem base
- Navegação com `MaterialPageRoute`
- Armazenamento temporário com listas em memória (sem persistência local)
- Utilização de `TextEditingController` para formular dados do usuário

---

## 🔧 Como Executar

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/danielmariae/app_address.git
   cd app_address
   ```

2. **Instale as dependências**:
   ```bash
   flutter pub get
   ```

3. **Execute a aplicação**:
   ```bash
   flutter run
   ```

---

## ⚙️ Melhorias Futuras

- Integração com banco de dados local (ex: SQLite ou Hive)
- Validação de login persistente com autenticação real
- Testes automatizados
- UI mais sofisticada com feedbacks visuais

---

## 👤 Autor

Desenvolvido por **Lucas Santos**

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.
