# Mermaid Diagrams

Dokumen ini mengumpulkan diagram besar untuk course RQueue.

Setiap modul juga punya diagram kontekstual di dalam file modul masing-masing.

## Course Flow

```mermaid
flowchart TD
    A[Setup Rust] --> B[Rust Basic]
    B --> C[Ownership Borrowing]
    C --> D[Struct Enum Result]
    D --> E[Cargo Module Test]
    E --> F[CLI Clap Serde]
    F --> G[Async Tokio]
    G --> H[TCP Protocol]
    H --> I[Project Scaffold]
    I --> J[Protocol Parser]
    J --> K[In-Memory Broker]
    K --> L[TCP Server CLI]
    L --> M[ACK Retry DLQ]
    M --> N[WAL Recovery]
    N --> O[Client SDK]
    O --> P[Example Apps]
    P --> Q[Benchmark]
    Q --> R[Admin API Optional]
```

## Final Architecture

```mermaid
flowchart TD
    PublisherApp[Publisher App] --> ClientSDK[rqueue-client SDK]
    ConsumerApp[Consumer App] --> ClientSDK
    CLI[rqueue-cli] --> ClientSDK
    Bench[rqueue-bench] --> ClientSDK

    ClientSDK --> Protocol[rqueue-protocol]
    Protocol --> TCP[TCP]
    TCP --> Server[rqueue-server]
    Server --> Core[rqueue-core]
    Core --> WAL[WAL]
    Core --> DLQ[DLQ]

    Admin[Admin API Optional] --> Core

    style ClientSDK fill:#e8f3ff,stroke:#2563eb,stroke-width:2px
    style Admin fill:#f3f4f6,stroke:#6b7280,stroke-width:2px
```

## Publisher Flow

```mermaid
sequenceDiagram
    participant App as Publisher App
    participant SDK as RQueue SDK
    participant Protocol as Protocol Encoder
    participant Server as RQueue Server
    participant Broker as Broker Core

    App->>SDK: publish(topic, payload)
    SDK->>Protocol: encode PUB command
    Protocol-->>SDK: "PUB topic payload\n"
    SDK->>Server: send over TCP
    Server->>Broker: append message to topic
    Broker-->>Server: message_id
    Server-->>SDK: PUBLISHED message_id
    SDK-->>App: PublishResult
```

## Consumer Flow

```mermaid
sequenceDiagram
    participant App as Consumer App
    participant SDK as RQueue SDK
    participant Server as RQueue Server
    participant Broker as Broker Core

    App->>SDK: consumer.next()
    SDK->>Server: SUB topic group
    Server->>Broker: poll next message
    Broker-->>Server: message
    Server-->>SDK: MESSAGE id payload
    SDK-->>App: Message object

    App->>SDK: message.ack()
    SDK->>Server: ACK topic group id
    Server->>Broker: mark as acked
    Broker-->>Server: ok
    Server-->>SDK: OK
    SDK-->>App: Result<()>
```

## Message Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Ready
    Ready --> InFlight: consumer.next()
    InFlight --> Acked: ack()
    InFlight --> Ready: nack() / timeout retry
    Ready --> DLQ: max retry exceeded
    Acked --> [*]
    DLQ --> [*]
```

## WAL Recovery

```mermaid
sequenceDiagram
    participant Server as RQueue Server
    participant WAL as Write-Ahead Log
    participant Core as Broker Core

    Server->>WAL: read log from beginning
    WAL-->>Server: PUB records
    Server->>Core: restore messages
    WAL-->>Server: ACK/NACK records
    Server->>Core: apply final states
    Server-->>Server: broker ready
```
