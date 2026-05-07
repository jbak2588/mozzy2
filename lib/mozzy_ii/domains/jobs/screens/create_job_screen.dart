import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../models/job_post_model.dart';
import '../providers/job_provider.dart';

class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key});

  @override
  ConsumerState<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();

  JobType _jobType = JobType.fullTime;
  WorkType _workType = WorkType.onsite;
  SalaryType _salaryType = SalaryType.monthly;
  String _category = 'restaurant';

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _descriptionController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionState = ref.watch(jobActionControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('jobs.create'.tr()),
      ),
      body: actionState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(_titleController, 'jobs.jobTitle'.tr()),
                    _buildTextField(_companyController, 'jobs.companyName'.tr()),
                    _buildDropdown<String>(
                      label: 'jobs.category'.tr(),
                      value: _category,
                      items: ['restaurant', 'retail', 'office', 'service', 'other'],
                      onChanged: (v) => setState(() => _category = v!),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown<JobType>(
                            label: 'jobs.jobType'.tr(),
                            value: _jobType,
                            items: JobType.values,
                            itemLabel: (v) => 'jobs.type.${v.name}'.tr(),
                            onChanged: (v) => setState(() => _jobType = v!),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildDropdown<WorkType>(
                            label: 'jobs.workType'.tr(),
                            value: _workType,
                            items: WorkType.values,
                            itemLabel: (v) => 'jobs.workType.${v.name}'.tr(),
                            onChanged: (v) => setState(() => _workType = v!),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildDropdown<SalaryType>(
                      label: 'jobs.salary'.tr(),
                      value: _salaryType,
                      items: SalaryType.values,
                      itemLabel: (v) => 'jobs.salaryType.${v.name}'.tr(),
                      onChanged: (v) => setState(() => _salaryType = v!),
                    ),
                    if (_salaryType != SalaryType.negotiable) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              _salaryMinController,
                              'jobs.salaryMin'.tr(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildTextField(
                              _salaryMaxController,
                              'jobs.salaryMax'.tr(),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                    ],
                    _buildTextField(
                      _descriptionController,
                      'jobs.description'.tr(),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text('jobs.create'.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'jobs.requiredField'.tr();
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    String Function(T)? itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items.map((e) {
            return DropdownMenuItem<T>(
              value: e,
              child: Text(itemLabel != null ? itemLabel(e) : e.toString()),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final controller = ref.read(jobActionControllerProvider.notifier);
    
    await controller.createJob(
      title: _titleController.text,
      companyName: _companyController.text,
      description: _descriptionController.text,
      category: _category,
      jobType: _jobType,
      workType: _workType,
      salaryType: _salaryType,
      salaryMin: int.tryParse(_salaryMinController.text) ?? 0,
      salaryMax: int.tryParse(_salaryMaxController.text) ?? 0,
    );

    final state = ref.read(jobActionControllerProvider);
    
    if (state.hasError) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('jobs.createFailed'.tr())),
        );
      }
    } else if (!state.isLoading) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('jobs.createSuccess'.tr())),
        );
        context.pop();
      }
    }
  }
}
