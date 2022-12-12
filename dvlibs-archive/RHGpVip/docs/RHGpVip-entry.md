This page is the netry of the whole RHGpVip project. current develop version is v1.
The project id of RHGpVip is **GPV**.

# v1
## Application examples




## Strategies & Features

### allocating by a package
[[GPV-package-v1]]
### provide a user protocol
users can override the basic protocol so that they can write the translate() and signal2transaction() APIs with the specific protocol.

### support user protocol
The base protocol is [[GPV-GpvProtocolBase-v1]], it provides some of the virtual APIs that can be written by users to add their own protocol. Users can override the base protocol with their own created protocol in the component where instantiated the GpvAgent. For example:
`GpvAgent#(REQ,RSP) gpv;`
`uvmFactory.set_inst_override_by_type(<userProtocolType>,<GpvProtocolBase>`
### cycle based vectors driving
driver will get the sequence item and call a protocol object which will be overridden by user to translate a transaction into drive object class. The drive object class is a standard formatted object that stores the driving information. Such as how many cycles this transaction has, for each transaction, which part of the interface been driven.
In drive API of the protocol, the program will drive all vectors as cycles available in drive object. For example, the drive object has record all cycles need to drive of this transaction, and for each cycle, it records all vectors that need to drive. So the protocol's drive API is not available for users to override, it always executed with the single rule.
### driving and translating mechanism
In the driver, when it receives a transaction, for example, a user specified trans: `userGpvSeqItem`. it will be translated to GpvDriveObject first, through the user specified protocol ([[#support user protocol|user protocol|]]). In the driver, the executing procedures will be like:
`get_next_item(req);`
`protocol.translate(req,driveObject);`
`protocol.drive(driveObject);`
As above shows, driver simply called the user protocol's translate and drive API, the correct information should stored in driveObject, the detailed drive mechanism locates in: [[#cycle based vectors driving]].
### GpvDriveObject mechanism
The drive object mechanism used to store information that translated from transactions. The drive object is created by driver, and stores information by the protocol, and then drive by protocol. It stores all necessary information and been called easily.
relative links:
![[GPV-GpvDriveObject-v1]]





