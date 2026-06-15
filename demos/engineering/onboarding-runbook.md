# New User Onboarding Runbook (Manual Process)

> SYNTHETIC DEMO DOC - Make-A-Wish America IT. All values fabricated.
> Use this checklist as the input for the "turn a runbook into a script" demo.

When HR submits a new-hire ticket, the IT onboarding coordinator performs these
steps **by hand** in the Entra admin center. The goal of the demo is to turn this
into the automated `Provision-NewUser.ps1` script.

## Inputs from the HR ticket
- First name, last name
- Department (e.g., Wish Granting, Finance, Marketing, IT)
- Start date
- Manager name

## Manual steps

1. Sign in to the Entra admin center with an onboarding admin account.
2. **Create the user**
   - Display name: `First Last`
   - User principal name: `first.last@makeawishdemo.onmicrosoft.com`
   - Mail nickname: `first.last`
   - Account enabled: Yes
3. **Set a temporary password**
   - Generate a 12-character random password.
   - Require the user to change it at first sign-in.
4. **Add to the department security group**
   - Group naming convention is `Dept-<Department>` (e.g., `Dept-Finance`).
   - If the group does not exist, escalate to the IT lead (do NOT proceed).
5. **Assign a license**
   - Confirm at least one Microsoft 365 E3 seat is available.
   - If seats are available, assign the E3 license.
   - If none are available, leave unlicensed and note it on the ticket.
6. **Notify**
   - Email the manager the temporary password and the UPN.
   - Close the ticket.

## Notes / gotchas
- Watch the casing on the mail nickname (always lowercase).
- Double-check the group name spelling - a typo silently puts the user in no group.
- We have been burned before by assigning a license when none were actually free.
