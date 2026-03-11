# Skill: Form Handling

**Tier:** Foundation
**Category:** UI Patterns
**Created:** Marketplace
**Status:** Active
**Times Used:** 0

## What This Skill Solves
Forms are the most complex UI pattern: validation, error display, multi-step flows, file uploads, dirty checking, accessibility, and submission handling all intersect. Ad-hoc form implementations create inconsistent validation, poor error UX, lost data on navigation, and accessibility violations. This skill provides a complete form architecture.

## The Approach
React Hook Form for state management (uncontrolled inputs for performance, controlled API for integration). Zod for schema-based validation with type inference. Per-field inline errors with accessible announcements. Every form handles loading, success, error, and dirty states.

## When to Use This
- Any form beyond a single input (search bars are fine without this)
- Multi-step wizards or forms with conditional fields
- Forms that need validation, dirty checking, or file uploads
- When form re-renders are causing performance issues

## When NOT to Use This
- Simple search inputs or toggles -- a plain `useState` is fine
- Server-rendered forms with full page reloads (traditional MPA)
- Forms entirely managed by a third-party component (e.g., Stripe Elements)

## Steps
1. **Define the schema first.** Write a Zod schema that describes the form data. Use `.transform()` for coercion, `.refine()` for cross-field validation. Infer the TypeScript type from the schema -- single source of truth for both validation and types.

2. **Initialize React Hook Form with the Zod resolver.** `useForm<FormValues>({ resolver: zodResolver(schema), defaultValues })`. Always provide `defaultValues` -- it prevents uncontrolled-to-controlled warnings and sets up reset behavior.

3. **Register fields.** Use `register()` for native inputs (best performance -- no re-renders on change). Use `Controller` for third-party components (date pickers, selects, rich text) that need controlled input.

4. **Display errors inline.** Each field shows its error directly below the input. Use `formState.errors.fieldName?.message`. Style errors consistently (red text, error icon). Never show errors only at the top of the form -- users should not hunt for which field failed.

5. **Handle submission with all states.** Disable the submit button during submission (`formState.isSubmitting`). Show a loading indicator. On success, show confirmation and optionally reset the form. On error, show the API error at the form level (not per-field). Never lose form data on submission failure.

6. **Multi-step forms: state machine + per-step validation.** Track current step in state. Each step has its own Zod schema. Validate only the current step on "Next". Accumulate data across steps. The final step submits all accumulated data. Critical: use `key={step}` on the step renderer to reset component state between steps.

7. **File uploads need special handling.** Validate file type, size, and count before upload. Show a preview for images. Show upload progress (use `XMLHttpRequest` or `fetch` with a readable stream). Drag-and-drop is expected UX -- use a dropzone library or the HTML5 drag events.

8. **Dirty checking: warn on unsaved changes.** Track dirty state via `formState.isDirty`. Register a `beforeunload` handler for browser navigation. Use a route guard (React Router's `useBlocker` or `Prompt`) for in-app navigation. Remove both handlers after successful submission.

9. **Accessibility is not optional.** Every input has a `<label>` associated via `htmlFor`/`id`. Errors are announced to screen readers with `aria-describedby` pointing to the error element and `aria-invalid={true}` on the input. Focus management: on submission error, focus the first invalid field. Keyboard navigation: tab order is logical, enter submits the form.

10. **Reset and default values.** `reset()` restores the form to `defaultValues`. For edit forms, fetch the entity and pass it as `defaultValues` -- or call `reset(fetchedData)` after the data loads. Never manually set each field with `setValue` when resetting.

## Example
```tsx
// schemas/user.ts -- Zod schema as single source of truth
const userFormSchema = z.object({
  name: z.string().min(2, 'Name must be at least 2 characters'),
  email: z.string().email('Invalid email address'),
  role: z.enum(['admin', 'editor', 'viewer'], {
    errorMap: () => ({ message: 'Select a role' }),
  }),
  bio: z.string().max(500, 'Bio must be under 500 characters').optional(),
  avatar: z
    .instanceof(FileList)
    .optional()
    .refine(
      (files) => !files?.length || files[0].size <= 5 * 1024 * 1024,
      'Avatar must be under 5MB'
    )
    .refine(
      (files) => !files?.length || ['image/jpeg', 'image/png'].includes(files[0].type),
      'Avatar must be JPEG or PNG'
    ),
});

type UserFormValues = z.infer<typeof userFormSchema>;

// components/UserForm.tsx -- complete form with all states
function UserForm({ defaultValues, onSubmit }: UserFormProps) {
  const {
    register,
    handleSubmit,
    formState: { errors, isSubmitting, isDirty },
    reset,
  } = useForm<UserFormValues>({
    resolver: zodResolver(userFormSchema),
    defaultValues: defaultValues ?? { name: '', email: '', role: undefined, bio: '' },
  });

  // Dirty checking -- warn on unsaved changes
  useEffect(() => {
    const handler = (e: BeforeUnloadEvent) => {
      if (isDirty) { e.preventDefault(); }
    };
    window.addEventListener('beforeunload', handler);
    return () => window.removeEventListener('beforeunload', handler);
  }, [isDirty]);

  const [submitError, setSubmitError] = useState<string | null>(null);

  const handleFormSubmit = async (data: UserFormValues) => {
    setSubmitError(null);
    try {
      await onSubmit(data);
      reset(data); // mark as clean after successful save
    } catch (err) {
      setSubmitError(err instanceof ApiError ? err.message : 'Something went wrong');
    }
  };

  return (
    <form onSubmit={handleSubmit(handleFormSubmit)} noValidate>
      {submitError && (
        <div role="alert" className={styles.formError}>{submitError}</div>
      )}

      <div className={styles.field}>
        <label htmlFor="name">Name</label>
        <input
          id="name"
          {...register('name')}
          aria-invalid={!!errors.name}
          aria-describedby={errors.name ? 'name-error' : undefined}
        />
        {errors.name && (
          <span id="name-error" role="alert" className={styles.error}>
            {errors.name.message}
          </span>
        )}
      </div>

      <div className={styles.field}>
        <label htmlFor="email">Email</label>
        <input
          id="email"
          type="email"
          {...register('email')}
          aria-invalid={!!errors.email}
          aria-describedby={errors.email ? 'email-error' : undefined}
        />
        {errors.email && (
          <span id="email-error" role="alert" className={styles.error}>
            {errors.email.message}
          </span>
        )}
      </div>

      <div className={styles.field}>
        <label htmlFor="role">Role</label>
        <select
          id="role"
          {...register('role')}
          aria-invalid={!!errors.role}
          aria-describedby={errors.role ? 'role-error' : undefined}
        >
          <option value="">Select a role...</option>
          <option value="admin">Admin</option>
          <option value="editor">Editor</option>
          <option value="viewer">Viewer</option>
        </select>
        {errors.role && (
          <span id="role-error" role="alert" className={styles.error}>
            {errors.role.message}
          </span>
        )}
      </div>

      <div className={styles.field}>
        <label htmlFor="avatar">Avatar</label>
        <input
          id="avatar"
          type="file"
          accept="image/jpeg,image/png"
          {...register('avatar')}
          aria-invalid={!!errors.avatar}
          aria-describedby={errors.avatar ? 'avatar-error' : undefined}
        />
        {errors.avatar && (
          <span id="avatar-error" role="alert" className={styles.error}>
            {errors.avatar.message}
          </span>
        )}
      </div>

      <button type="submit" disabled={isSubmitting}>
        {isSubmitting ? 'Saving...' : 'Save'}
      </button>
    </form>
  );
}

// Multi-step form pattern
const STEPS = ['personal', 'preferences', 'review'] as const;

function MultiStepForm() {
  const [step, setStep] = useState(0);
  const [accumulated, setAccumulated] = useState<Partial<FullFormData>>({});

  const handleStepSubmit = (stepData: Partial<FullFormData>) => {
    const merged = { ...accumulated, ...stepData };
    setAccumulated(merged);

    if (step < STEPS.length - 1) {
      setStep(step + 1);
    } else {
      submitFullForm(merged as FullFormData);
    }
  };

  return (
    <div>
      <StepIndicator steps={STEPS} current={step} />
      {/* key={step} forces React to remount -- prevents stale state */}
      <StepForm
        key={STEPS[step]}
        step={STEPS[step]}
        defaultValues={accumulated}
        onSubmit={handleStepSubmit}
        onBack={step > 0 ? () => setStep(step - 1) : undefined}
      />
    </div>
  );
}
```

## Gotchas
- `key={step.id}` on multi-step form renderers is critical. Without it, React reuses component state across steps -- input values from step 1 bleed into step 2, validation state is wrong, and `isDirty` is unreliable.
- `z.boolean().default(true)` makes the TypeScript type `boolean` (required), not optional. Manual object construction must include the field. If you want optional, use `z.boolean().optional().default(true)`.
- React Hook Form's `register()` returns a `ref` -- do not also pass your own `ref` to the same element. Use `useWatch` or `getValues` if you need to read values outside the form.
- `formState.errors` is populated lazily. You must destructure `errors` from `formState` (not read it as `form.formState.errors`) for the Proxy to track which errors you are reading.
- File inputs are always uncontrolled in HTML. Do not try to set their value programmatically. On reset, clear the input via `ref.current.value = ''` or re-key the component.
- `noValidate` on the form element disables browser-native validation bubbles. You want this when using Zod validation -- otherwise users see two layers of error messages.
- `beforeunload` event cannot show custom messages in modern browsers. It shows a generic "Changes you made may not be saved" dialog. But you still need to register it.
- `<form>` elements inside `<form>` elements are invalid HTML and cause unpredictable submit behavior. Use fieldsets for logical grouping, not nested forms.
- Password fields should not use `autocomplete="off"` -- it breaks password managers. Use `autocomplete="new-password"` for registration and `autocomplete="current-password"` for login.

## Related Skills
- component-architecture -- form components follow the same composition patterns
- state-management -- form state is a distinct category that deserves its own tool
- api-integration -- form submission uses the mutation pattern from the API layer
- input-validation -- the Zod schemas used here are the same validation approach used server-side
