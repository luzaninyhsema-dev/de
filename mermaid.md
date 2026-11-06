## Mermaid
**Mermaid** - это сильно упрощённый и далёкий аналог **UML** - специальный язык описани блок-схем, графиков и диаграмм с их визуализацией.
> **Самсостоятельно доделать это ридми**
### Блок схемы
#### Базовая структура 1
```mermaid
flowchart LR
    A[Вопрос: Как сделать список?] --> B["Ответ: `-` или `*`"]
    A --> C["Пример: \n - Пункт 1 \n"]
```
* `flowchart` - блок-схема
* `LR` - направление вправо
* `A[],B[],C[]` - прямоугольник
* --> - стрелка связи
Виды Mermaid-диаграмм
- Блок-схемы - `graph`, `flowchart`
- Последовательности - `sequenceDiagram`
- Классы - `classDiagram`
- Диаграмма Ганта - `gant`
- Круговые - `pie`
- Состояния
- ER-диаграммы
- Графы зависимостей
#### Полный синтаксис блок-схем
### Диаграмма последовательности
```mermaid
sequenceDiagram
    autonumber
    actor User as Пользователь
    participant Browser as Браузер
    participant Server as Сервер
    participant DB as База данных

    User->>Browser: Ввод логина и пароля
    Browser->>Server: POST /login (credentials)
    activate Server
    Server->>DB: SELECT * FROM users WHERE login=?
    activate DB
    DB-->>Server: Данные пользователя
    deactivate DB

    alt Данные верны
        Server-->>Browser: 200 OK + JWT-токен
        Browser-->>User: Переход в личный кабинет
    else Данные неверны
        Server-->>Browser: 401 Unauthorized
        Browser-->>User: Сообщение об ошибке
    end
    deactivate Server
```
### Диаграмма класса
```mermaid
classDiagram
    class App {
        -Router router
        -Store store
        +init() void
        +mount(el) void
    }

    class Router {
        -Map~String, Route~ routes
        +add(path, component) void
        +navigate(path) void
        +resolve(path) Component
    }

    class Store {
        -Object state
        -List~Function~ listeners
        +getState() Object
        +dispatch(action) void
        +subscribe(fn) Function
    }

    class Component {
        <<abstract>>
        #Element el
        +render() void
        +destroy() void
    }

    class HomePage {
        +render() void
    }

    class LoginPage {
        -Form form
        +render() void
        +submit() void
    }

    class ApiClient {
        -String baseUrl
        +get(path) Promise
        +post(path, data) Promise
    }

    App *-- Router
    App *-- Store
    App --> ApiClient
    Component <|-- HomePage
    Component <|-- LoginPage
    Router --> Component : создаёт
```
### Диаграмма Ганта
```mermaid
gantt
    title План разработки my-project
    dateFormat  YYYY-MM-DD
    axisFormat  %d.%m
    excludes    weekends

    section Подготовка
    Сбор требований            :done,    req,     2026-11-02, 5d
    Проектирование архитектуры :active,  arch,    2026-11-09, 4d

    section Разработка
    Вёрстка (HTML/CSS)         :         layout,  after arch, 7d
    JS-модули (роутер, store)  :         js,      after layout, 8d
    Интеграция с API           :         api,     after js, 5d

    section Тестирование
    Unit-тесты                 :         unit,    after js, 4d
    E2E-тесты                  :         e2e,     after api, 3d

    section Релиз
    Деплой на staging          :milestone, stage, after e2e, 0d
    Приёмка заказчиком         :         accept,  after stage, 3d
    Релиз в production         :milestone, prod,  after accept, 0d
```
### Граф зависимостей
```mermaid
graph TD
    A[app-frontend] --> B[ui-components]
    A --> C[auth-lib]
    B --> D[icons]
    B --> E[utils]
    C --> E
    F[app-backend] --> C
    F --> G[db-client]
    G --> H[postgres]
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style F fill:#bbf,stroke:#333,stroke-width:2px
```
### Диаграмма состояний
```mermaid
stateDiagram-v2
    [*] --> Idle

    state "Авторизация" as Auth {
        [*] --> WaitCredentials
        WaitCredentials --> Checking : submit
        Checking --> WaitCredentials : ошибка
        Checking --> Success : OK
        Success --> [*]
    }

    Idle --> Auth : login
    Auth --> LoggedIn : успех

    state LoggedIn {
        [*] --> Browsing
        Browsing --> Cart : добавить товар
        Cart --> Checkout : оформить
        Checkout --> Browsing : отмена
        Checkout --> OrderPlaced : подтвердить
        OrderPlaced --> Browsing : новый заказ
    }

    LoggedIn --> Idle : logout
    LoggedIn --> Error : сбой сети
    Error --> LoggedIn : retry
    Error --> Idle : выход

    state Choice <<choice>>
    Browsing --> Choice : проверить сессию
    Choice --> Idle : истекла
    Choice --> Browsing : активна

    state Fork <<fork>>
    Checkout --> Fork
    Fork --> Payment
    Fork --> ReserveStock
    Payment --> Join
    ReserveStock --> Join
    state Join <<join>>
    Join --> OrderPlaced

    [*] --> Idle
```
### Юзер-джайрни
```mermaid
journey
    title Путь пользователя: покупка товара
    section Поиск
      Заходит на сайт: 5: Пользователь
      Ищет товар: 4: Пользователь
      Смотрит карточку: 5: Пользователь
    section Оформление
      Добавляет в корзину: 5: Пользователь
      Вводит данные: 3: Пользователь
      Выбирает оплату: 4: Пользователь
    section Оплата
      Оплачивает картой: 2: Пользователь
      Ждёт подтверждения: 3: Пользователь
    section Получение
      Получает письмо: 5: Пользователь
      Отслеживает доставку: 4: Пользователь
      Получает товар: 5: Пользователь
```
### Кастомизация стилей
```mermaid
flowchart TD
    Start([Старт]) --> Check{Валидация}
    Check -->|OK| Save[(База данных)]
    Check -->|Fail| Error[Ошибка]
    Save --> Done([Готово])

    classDef startEnd fill:#4A90D9,stroke:#2C5F8A,stroke-width:2px,color:#fff
    classDef decision fill:#E8A838,stroke:#B8860B,color:#000
    classDef success fill:#50B86C,stroke:#2E7D32,color:#fff
    classDef fail fill:#E74C3C,stroke:#922B21,color:#fff
    classDef storage fill:#9B59B6,stroke:#6C3483,color:#fff

    class Start,Done startEnd
    class Check decision
    class Save success
    class Error fail
    class Save storage
```
#### Классы CSS
```mermaid
flowchart LR
    A[Старт] --> B{Проверка}
    B -->|OK| C[Успех]
    B -->|Fail| D[Ошибка]

    %% Определяем классы
    classDef success fill:#50B86C,stroke:#2E7D32,color:#fff
    classDef fail fill:#E74C3C,stroke:#922B21,color:#fff

    %% Применяем классы к узлам
    class C success
    class D fail
```

#### Интерактивность
```mermaid
flowchart TD
    A([Старт]) --> B{Выбор действия}
    B -->|Профиль| C[Открыть профиль]
    B -->|Заказы| D[Мои заказы]
    B -->|Выход| E[Выйти]

    C --> F([Конец])
    D --> F
    E --> F

    click C callback "Открыть страницу профиля"
    click D callback "Показать список заказов"
    click E "https://example.com/logout" "Выйти из аккаунта" _blank
```
### Круговая диаграмма
```mermaid
pie
    title ОС на десктопе
    "Windows" : 70
    "MacOS" : 20
    "Linux" : 7
    "Other" : 3
```