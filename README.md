# TRACTIAN CHALLENGE - ASSET TREE VIEW

Uma aplicação mobile para visualizar os Ativos de cada Compania em forma de árvore.

## Índice

1. [Requisitos](#requisitos)
2. [Instalação](#instalação)
3. [Configuração](#configuração)
4. [Uso](#uso)
5. [Demonstração](#demonstração)
6. [Estrutura do Projeto](#estrutura-do-projeto)

## Requisitos

Para rodar esse projeto você precisará instalar o [Git](https://git-scm.com/downloads), [Android Studio](https://developer.android.com/studio/install?hl=pt-br) e o [Flutter](https://docs.flutter.dev/get-started/install) na sua máquina. Você pode usar a IDE do Android Studio para visualizar o projeto ou usar outra IDE de sua preferência, como [VSCode](https://code.visualstudio.com/download).

## Instalação

Para instalar o projeto, abra o **Explorador de Arquivos** e crie uma pasta no diretório de sua preferência, navegue até essa pasta, abra o terminal e execute o seguinte comando:

```bash
$ git clone http://github.com/zarref-semog/tractian-challenge.git
```

Abra o Android Studio e execute os [seguintes passos](https://developer.android.com/studio/run/managing-avds?hl=pt-br).

## Configuração

Na pasta do projeto, abra o terminal e execute o seguinte comando:

```bash
$ flutter doctor
```

Para aceitar a licença do Android, execute:

```bash
$ flutter doctor --android-licenses
```

Verifique novamente se está tudo certo:
```bash
$ flutter doctor
```

Com isso, o seu ambiente estará pronto para executar a aplicação.

## Uso

Abra o Android Studio. Selecione a opção **More Actions->Virtual Device Manager** e inicialize o dispositivo virtual. Quando o dispositivo estiver pronto, abra o terminal na pasta do projeto e execute o seguinte comando:

```bash
$ flutter pub get
```
Isso irá instalar todas as dependências do projeto. 

Em seguida, execute ```flutter run``` para rodar o projeto:

```bash
$ flutter run
```

## Demonstração

[Link do Video](https://youtube.com)

## Estrutura do Projeto

```bash
tractian-challenge
├── android
├── ios
├── images
├── lib
│   ├── api
│   ├── components
│   ├── models
│   ├── screens
│   ├── main.dart
│   ├── router_generator.dart
├── pubspec.lock
├── pubspec.yaml
```

- Os diretórios **android** e **ios** contêm os arquivos necessários para rodar a aplicação nos respectivos sistemas operacioanis.

- O diretório **images** contém as imagens utilizadas na aplicação.
  > Qualquer arquivo dentro de **images** deve ser adicionado ao arquivo pubspec.yaml dentro de **assets**.

- O diretório **lib** contém os subdiretórios **models** (modelos), **screens** (telas), **api** (arquivo JSON), **components** (widgets customizados).

- O diretório **lib** contém os arquivos **router_generator** (gerador de rotas) e **main.dart**.

- Os arquivos **pubspec.yml** e **pubspec-lock** contêm assets, configurações e outras dependências do projeto.


Desenvolvido por [Murilo Gomes Ferraz](https://github.com/zarref-semog) 
