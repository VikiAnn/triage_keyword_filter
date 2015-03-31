## Triage Keyword Filter

The purpose of this code challenge is to create a keyword filter for triaging patients using an online
appointment scheduling tool. Patients in a potential emergent state should be directed to contact emergency
personnel rather than waiting on a scheduled appointment.

This keyword filter accepts a string representation of a patient's self reported symptoms and analyzes it
for keywords that indicate a potential emergency. Lists of keywords are kept in a module and may be updated
as needed.

Challenges, concerns and potential problems I identified during the process of building the filter include:

  * Many of the keywords should be accepted as "any variant," which may include present or past tense variants
  or even possibly typos or synonyms. Identifying all possible variants seemed beyond the scope of this code challenge,
  but in a real world use case would be an important concern.
  * Some keywords were in quotes, and some were not (in particular, medical terms didn't appear in quotes.) Is a
  patient likely to type out a complaint of tachycardia or syncope, or are there other lists of terms or keywords that
  might indicate such conditions?
  * Design concerns, such as whether an `attr_reader` belongs on something like a filter. Are `words` and `patient_report`
  attributes of a filter, or should there be a separate class, like a `PatientReport`, perhaps?
  * Storing the full string of the `patient_report` in addition to the separated words seemed possibly redundant, but
  I found it useful to break the strings into arrays to utilize enumerable methods like `.any?`, while also retaining
  the ability to look for consecutive words in the original string.
