# Observability

## Definitions of Observability

“Less formally, this means that one can determine the behavior of the entire system from the system’s outputs. If a system is not observable, this means that the current values of some of its state variables cannot be determined through _output sensors_.”

From [https://www.infoq.com/articles/charity-majors-observability-failure/](https://www.infoq.com/articles/charity-majors-observability-failure/)

> "Monitor everything". Dude, you can't. You _can't_. People waste so much time doing this that they lose track of the _critical path_, and their important alerts drown in fluff and cruft. In the chaotic future we're all hurtling toward, you actually have to have the discipline to have radically _fewer_ paging alerts ... not more. Request rate, latency, error rate, saturation. Maybe some end-to-end checks that stress critical Key Performance Indicator \(KPI\) code paths.
>
> However, I would argue that the health of the system no longer matters. We've entered an era where what matters is the health of each individual event, or each individual user's experience, or each shopping cart's experience \(or other high cardinality dimensions\). With distributed systems you don't care about the health of the system, you care about the health of the event or the slice.
>
> This is why you're seeing people talk about observability instead of monitoring, about unknown-unknowns instead of known-unknowns, and about distributed tracing, honeycomb, and other event-level tools aimed at describing the internal state of the system to external observers.
>
> We use RDS and Aurora at honeycomb, despite being quite good at databases ourselves, because it isn't our core competency. If AWS goes down, let them get paged.Where that doesn't let me off the hook, is observability, instrumentation and architecture. We have architected our system to be resilient to as many problems as possible, including an AWS Availability Zone \(AZ\) going down. We have instrumented our code, and we slurp lots of internal performance information out of MySQL, so that we can ask any arbitrary question of our stack -- including databases.
>
> It will always be the engineer's responsibility to understand the operational ramifications and failure models of what we're building, auto-remediate the ones we can, fail gracefully where we can't, and shift as much operational load to the providers whose core competency it is as humanly possible. But honestly, databases are just another piece of software. In the future, you want to treat databases as much like stateless services as possible \(while recognizing that operably speaking they aren't\), and as much like the rest of your stack as possible.

